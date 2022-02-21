import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:near_api/environment.dart';
import 'package:near_api/near_api.dart';

import 'dart:core';

import 'package:near_api/utils/key_pair.dart';

import 'test_utils.dart';

Future<void> main() async {

  var contractId = generateUniqueString("test");
  Near near = Near.connect(Env.testNet);
  // var workingAccount = await createAccount(near);

  // test('loading account after adding a full key', () {
  //   var keyPair = KeyPair.fromRandom("ed25519");
  //   borsh
  //   expect(() => signer.signMessage("message", "user", "network"), throwsA(isA<ArgumentError>().having((error) => error.message, "message", "Key for user not found in network")));
  // });

  test('test create account', () async {
    var keyPair = KeyPair.fromRandom("ed25519");
    var accountId = "test-account-${Random().nextInt(1000000)}";
    print("Account Id: " +accountId);
    var account = await near.createAccount(accountId, keyPair.getPublicKey());
    expect(account.data?.id, accountId);
  });

}
