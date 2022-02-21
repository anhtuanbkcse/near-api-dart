import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:near_api/near_api.dart';
import "package:bs58/bs58.dart" as bs58;
import 'package:near_api/utils/key_pair.dart';

void main() {
  test('Test keyPair from Seed Phrase', () {
    const seed = "tissue illness drill gift finger tobacco clog affair cry spoon blade alarm";
    const pk = "ed25519:7pVPCpnbaQmm5sgCEpejiyi89R7APkMkk5PmzKsSQYxN";
    const sk = "ed25519:Hp2NatXY55rs7RrU5UJcrsjAXiir6VFuh86yzvzCrqzvgFn9AveUe87vhnZwEz5jnpAkpiDhMrUWGhoVMFg9SiJ";
    var keyPair = Near.keyPairFromSeedPhrase(seed);
    // var keyPair = Near.createKeyPair();
    expect(keyPair.toString(), sk, reason: "SecretKey not matched for ${keyPair.toString()}");
    expect(keyPair.getPublicKey().toString(), pk, reason: "PublicKey not matched for ${keyPair.getPublicKey().toString()}");
  });

  test("Test sign message", () {
    var keyPair = Near.keyPairFromSecretKey("26x56YPzPDro5t2smQfGcYAPy3j7R2jB2NUb7xKbAGK23B6x4WNQPh3twb6oDksFov5X8ts5CtntUNbpQpAKFdbR");
    expect(keyPair.getPublicKey().toString(), "ed25519:AYWv9RAN1hpSQA4p1DLhCNnpnNXwxhfH9qeHN8B4nJ59", reason: "Public key not matched for ${keyPair.getPublicKey().toString()}");
    var message = "message";
    var signature = keyPair.sign(message);
    expect(bs58.base58.encode(Uint8List.fromList(signature.signature.codeUnits)), "26gFr4xth7W9K7HPWAxq3BLsua8oTy378mC1MYFiEXHBBpeBjP8WmJEJo8XTBowetvqbRshcQEtBUdwQcAqDyP8T", reason: "Signature not matched for message");
  });

  test("Test sign and verify with random", () {
    var keyPair = Near.keyPairFromRandom();
    var message = "message";
    var signature = keyPair.sign(message);
    expect(keyPair.verify(message, signature.signature), true, reason: "Verify message not matched");
  });

  test("test sign and verify with public key", () {
    var keyPair = KeyPairEd25519(secretKey: '5JueXZhEEVqGVT5powZ5twyPP8wrap2K7RdAYGGdjBwiBdd7Hh6aQxMP1u3Ma9Yanq1nEv32EW7u8kUJsZ6f315C');
    var message = "message";
    var signature = keyPair.sign(message);
    var publicKey = PublicKey.fromString("ed25519:EWrekY1deMND7N3Q7Dixxj12wD7AVjFRt2H9q21QHUSW");
    expect(publicKey.verify(message, signature.signature), true, reason: "Verify with public key not matched");
  });

  test("test from secret", () {
    var keyPair = KeyPairEd25519(secretKey: '5JueXZhEEVqGVT5powZ5twyPP8wrap2K7RdAYGGdjBwiBdd7Hh6aQxMP1u3Ma9Yanq1nEv32EW7u8kUJsZ6f315C');
    expect(keyPair.publicKey.toString(), "ed25519:EWrekY1deMND7N3Q7Dixxj12wD7AVjFRt2H9q21QHUSW", reason: "Public key from secret not matched");
  });

  test("test convert to string", () {
    var keyPair = Near.keyPairFromRandom();
    var newKeyPair = KeyPair.fromString(keyPair.toString());
    expect(keyPair.toString(), newKeyPair.toString());

    var keyString = "ed25519:2wyRcSwSuHtRVmkMCGjPwnzZmQLeXLzLLyED1NDMt4BjnKgQL6tF85yBx6Jr26D2dUNeC716RBoTxntVHsegogYw";
    var keyPair2 = KeyPair.fromString(keyString);
    expect(keyPair2.toString(), keyString);
  });
}
