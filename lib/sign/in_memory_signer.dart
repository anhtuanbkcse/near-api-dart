

import 'package:near_api/keystore/in_memory_keystore.dart';
import 'package:near_api/keystore/keystore.dart';
import 'package:near_api/sign/signed_message.dart';
import 'package:near_api/sign/signer.dart';
import 'package:near_api/utils/key_pair.dart';

class InMemorySigner extends Signer{

  InMemorySigner(KeyStore keyStore) : super(type: 'InMemorySigner', keyStore: keyStore);

  static Signer fromKeyPair(String networkId, String accountId, KeyPair keyPair) {
    KeyStore keyStore = InMemoryKeyStore();
    keyStore.setKey(networkId, accountId, keyPair);
    return InMemorySigner(keyStore);
  }

  @override
  PublicKey createKey(String accountId, String networkId) {
    KeyPair keyPair = KeyPair.fromRandom("ed25519");
    keyStore.setKey(networkId, accountId, keyPair);
    return keyPair.getPublicKey();
  }


  @override
  PublicKey? getPublicKey(String accountId, String networkId) {
    KeyPair? keyPair = keyStore.getKey(networkId, accountId);
    return keyPair?.getPublicKey();
  }

  @override
  SignedMessage signMessage(String message, String accountId, String networkId) {
    KeyPair? keyPair = keyStore.getKey(networkId, accountId);
    if (keyPair == null) {
      throw ArgumentError("Key for user not found in network");
    }
    return keyPair.sign(message);
  }

  @override
  String toString() {
    return 'InMemorySigner($keyStore)';
  }
}