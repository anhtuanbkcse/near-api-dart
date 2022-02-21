

import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:near_api/sign/signed_message.dart';
import 'package:pinenacl/api.dart';
import 'package:pinenacl/tweetnacl.dart';
import "package:bs58/bs58.dart" as bs58;
import "package:bip39/bip39.dart" as bip39;

extension KeyTypeExtension on KeyType {
  static KeyType parse(String type){
    switch (type.toLowerCase()) {
      case "ed25519":
        return KeyType.typeED25519;
      default:
        return KeyType.typeED25519;
    }
  }
  String getString() {
    switch(this) {
      case KeyType.typeED25519:
        return "ed25519";
      default:
        return "ed25519";
    }
  }
}

extension ED25519String on String {
  Uint8List toUint8List() {
    return Uint8List.fromList(codeUnits);
  }
}

class KeyPairUtils {
  static const HARDENED_OFFSET = 0x80000000;

  static const ED25519_CURVE = 'ed25519 seed';

  static const PUBLIC_KEY_LENGTH = 32;

  static const SEED_KEY_LENGTH = 32;

  static const SECRET_KEY_LENGTH = 64;

  static const SIGNED_MESG_LENGTH = 64;

  static Set<Uint8List> getMasterKeyFromSeed(Uint8List seed) {
    var key = ED25519_CURVE.codeUnits;
    var hmac = Hmac(sha512, key);
    var i = hmac.convert(seed);
    return  {i.bytes.sublist(0,32).toUint8List(), i.bytes.sublist(32).toUint8List()};
  }

  static Set<Uint8List> ckdPriv(Set<Uint8List> keys, int index) {
    Uint8List buffer = Uint8List(4);
    buffer = writeUInt32BE(buffer, index);
    var byteBuilder = BytesBuilder();
    byteBuilder.add(Uint8List(1));
    byteBuilder.add(keys.first);
    byteBuilder.add(buffer);
    Uint8List data = byteBuilder.toBytes();
    var hmac = Hmac(sha512, keys.last);
    var i = hmac.convert(data);
    return {i.bytes.sublist(0,32).toUint8List(), i.bytes.sublist(32).toUint8List()};
  }

  static Set<Uint8List> derivePath(String path, Uint8List seed, {int offset = HARDENED_OFFSET}) {
    var keys = getMasterKeyFromSeed(seed);
    var segment = path.split("/").sublist(1).map((e) => e.replaceAll("'", '')).map((e) => int.parse(e));
    return segment.fold(keys, (Set<Uint8List> parentKeys, segment) => ckdPriv(parentKeys, segment + offset));
  }

  static Uint8List writeUInt32BE(Uint8List target, value) {
    target[0] = ((value & 0xffffffff) >> 24);
    target[1] = ((value & 0xffffffff) >> 16);
    target[2] = ((value & 0xffffffff) >> 8);
    target[3] = ((value & 0xffffffff) & 0xff);
    return target;
  }

  static Map<String, Uint8List> fromSeed(Uint8List seed) {
    var sk = Uint8List(SECRET_KEY_LENGTH);
    var pk = Uint8List(PUBLIC_KEY_LENGTH);
    for (var i = 0; i < 32; i++) {
      sk[i] = seed[i];
    }
    TweetNaCl.crypto_sign_keypair(pk, sk, seed);
    return { "public_key": pk, "secret_key": sk };

  }

  static Map<String, Uint8List> fromSecretKey(String privateKey) {
    var sk = bs58.base58.decode(privateKey);
    var pk = Uint8List(PUBLIC_KEY_LENGTH);
    for (var i = 0; i < pk.length; i++) {
      pk[i] = sk[32+i];
    }
    return { "public_key": pk, "secret_key": sk };
  }

  static Uint8List sign(Uint8List msg, Uint8List sk) {
    Uint8List signedMsg = Uint8List(SIGNED_MESG_LENGTH + msg.length);
    TweetNaCl.crypto_sign(signedMsg, 0, msg, 0, msg.length, sk);
    return signedMsg;
  }

  static Uint8List detached(Uint8List msg, Uint8List sk) {
    var signedMsg = sign(msg, sk);
    var sig = Uint8List(SIGNED_MESG_LENGTH);
    for (var i = 0; i < sig.length; i++) {
      sig[i] = signedMsg[i];
    }
    return sig;
  }

  static bool detachedVerify(Uint8List msg, Uint8List sig,  Uint8List pk) {

    var sm = Uint8List(SIGNED_MESG_LENGTH + msg.length);
    var m = Uint8List(SIGNED_MESG_LENGTH + msg.length);

    for (var i = 0; i < SIGNED_MESG_LENGTH; i++) {
      sm[i] = sig[i];
    }

    for (var i = 0; i < msg.length; i++) {
      sm[i + SIGNED_MESG_LENGTH] = msg[i];
    }

    return TweetNaCl.crypto_sign_open(m, 0, sm, 0, sm.length, pk) >= 0;
  }
}

class PublicKey {
  final KeyType keyType;
  final String data;

  const PublicKey({required this.keyType, required this.data});

  static PublicKey fromString(String encodedKey) {
    List<String> parts = encodedKey.split(":");
    if (parts.length == 1) {
      Codec<String, String> codec = utf8.fuse(base64);
      return PublicKey(keyType: KeyType.typeED25519, data: codec.decode(parts[0]));
    } else if (parts.length == 2) {
      return PublicKey(keyType: KeyTypeExtension.parse(parts[0]), data: parts[1]);
    } else {
      throw Error();
    }
  }

  @override
  String toString() {
    return '${keyType.getString()}:$data';
  }

  bool verify(String message, String signature) {
    switch (keyType) {
      case KeyType.typeED25519:
        var msg = Uint8List.fromList(sha256.convert(message.codeUnits).bytes);
        var sig = Uint8List.fromList(signature.codeUnits);
        return KeyPairUtils.detachedVerify(msg, sig, bs58.base58.decode(data));
      default: throw TypeError();
    }
  }

}

abstract class KeyPair {

  static KeyPair fromRandom(String curve){
    switch(curve.toUpperCase()) {
      case 'ED25519': return KeyPairEd25519.fromRandom();
      default: throw TypeError();
    }
  }

  static KeyPair fromSeedPhrase(String curve, String seedPhrase){
    switch(curve.toUpperCase()) {
      case 'ED25519': return KeyPairEd25519.fromSeedPhrase(seedPhrase);
      default: throw TypeError();
    }
  }

  static KeyPair fromString(String encodedKey) {
    List<String> parts = encodedKey.split(":");
    if (parts.length == 1) {
      return KeyPairEd25519(secretKey: parts[0]);
    } else if (parts.length == 2) {
      switch(KeyTypeExtension.parse(parts[0].toUpperCase())){
        case KeyType.typeED25519: return KeyPairEd25519(secretKey: parts[1]);
        default: throw TypeError();
      }
    } else {
      throw TypeError();
    }
  }

  PublicKey getPublicKey();
  String getPrivateKey();
  String? getSeedPhrase();
  SignedMessage sign(String message);
  bool verify(String message, String signature);
}


class KeyPairEd25519 extends KeyPair {

  String? seedPhrase;
  final String secretKey;
  late PublicKey publicKey;

  static const KEY_DERIVATION_PATH = "m/44'/397'/0'";

  Codec<String, String> codec = utf8.fuse(base64);


  KeyPairEd25519({required this.secretKey, String? publicKey, this.seedPhrase}) {
    if (publicKey == null) {
      var kp = KeyPairUtils.fromSecretKey(secretKey);
      // print("Keypair pk "+bs58.base58.encode(kp["public_key"]!));
      this.publicKey = PublicKey(
          keyType: KeyType.typeED25519, data: bs58.base58.encode(kp["public_key"]!));
    } else {
      this.publicKey = PublicKey(
          keyType: KeyType.typeED25519, data: publicKey);
    }
  }

  static String generateSeedPhrase() {
    return bip39.generateMnemonic();
  }


  static String normalizeSeedPhrase(String seedPhrase) {
    return seedPhrase.trim().split(RegExp("/s+/")).map((e) => e.toLowerCase()).join(" ");
  }

  static KeyPairEd25519 fromRandom() {
    String phrase = generateSeedPhrase();
    String seedPhrase = normalizeSeedPhrase(phrase);
    Uint8List seed =  bip39.mnemonicToSeed(seedPhrase);
    var keys = KeyPairUtils.derivePath(KEY_DERIVATION_PATH, seed);
    var kp = KeyPairUtils.fromSeed(keys.first);
    return KeyPairEd25519(
        secretKey: bs58.base58.encode(kp["secret_key"]!),
        publicKey: bs58.base58.encode(kp["public_key"]!),
        seedPhrase: seedPhrase);
  }

  static KeyPairEd25519 fromSeedPhrase(String seedPhrase) {
    Uint8List seed =  bip39.mnemonicToSeed(seedPhrase);
    var keys = KeyPairUtils.derivePath(KEY_DERIVATION_PATH, seed);
    var kp = KeyPairUtils.fromSeed(keys.first);
    return KeyPairEd25519(
        secretKey: bs58.base58.encode(kp["secret_key"]!),
        publicKey: bs58.base58.encode(kp["public_key"]!),
        seedPhrase: seedPhrase);
  }

  @override
  SignedMessage sign(String message) {
    var msg = Uint8List.fromList(sha256.convert(message.codeUnits).bytes);
    Uint8List signature = KeyPairUtils.detached(msg, bs58.base58.decode(secretKey));
    return SignedMessage(signature: String.fromCharCodes(signature), publicKey: publicKey.data);
  }

  @override
  bool verify(String message, String signature){
    return publicKey.verify(message, signature);
  }

  @override
  PublicKey getPublicKey() {
    return publicKey;
  }

  @override
  String getPrivateKey() {
    return 'ed25519:$secretKey';
  }

  @override
  String? getSeedPhrase() {
    return seedPhrase;
  }

  @override
  String toString() {
    return 'ed25519:$secretKey';
  }
}


enum KeyType {
  typeED25519
}
