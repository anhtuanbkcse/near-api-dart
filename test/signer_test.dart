
import 'package:flutter_test/flutter_test.dart';
import 'package:near_api/keystore/in_memory_keystore.dart';

import 'package:near_api/sign/in_memory_signer.dart';
import 'dart:core';

void main() {
  test('Test no key', () {
    var signer = InMemorySigner(InMemoryKeyStore());
    expect(() => signer.signMessage("message", "user", "network"), throwsA(isA<ArgumentError>().having((error) => error.message, "message", "Key for user not found in network")));
  });

}
