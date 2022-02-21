

import 'dart:math';

import 'package:near_api/domain/entities/account.dart';
import 'package:near_api/near_api.dart';

const accountLength = 40;
const networkId = "unittest";

String generateUniqueString(prefix) {
  var result = "$prefix-${DateTime.now()}-${Random().nextInt(1000000)}".replaceAll(" ", "-");
  var toAdd = max(accountLength - result.length, 1);
  for (var i = toAdd; i > 0; --i) {
    result += '0';
  }
  return result;
}

Future<Account> createAccount(Near near) async {
  var newAccountName = generateUniqueString("test");
  var newPublicKey = near.connection.signer?.createKey(newAccountName, networkId);
  var result = await near.createAccount(newAccountName, newPublicKey!);
  return result.data!;
}