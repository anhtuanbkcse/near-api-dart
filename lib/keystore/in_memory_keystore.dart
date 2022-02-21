

import 'package:near_api/keystore/keystore.dart';
import 'package:near_api/utils/key_pair.dart';

class InMemoryKeyStore extends KeyStore {

  Map<String, String> keys = {};

  @override
  clear() {
    keys.clear();
  }

  @override
  List<String> getAccounts(String networkId) {
    List<String> result = [];
    keys.forEach((key, value) {
      List<String> parts = key.split(":");
      if (parts[parts.length -1] == networkId){
        result.add(parts.sublist(0, parts.length - 1).join(":"));
      }
    });
    return result;
  }

  @override
  KeyPair? getKey(String networkId, String accountId) {
    String? value = keys['$accountId:$networkId'];
    return value != null ? KeyPair.fromString(value) : null;
  }

  @override
  List<String> getNetworks() {
    List<String> result = [];
    keys.forEach((key, value) {
      List<String> parts = key.split(":");
      result.add(parts[1]);
    });
    return result;
  }

  @override
  removeKey(String networkId, String accountId) {
    keys.remove('$accountId:$networkId');
  }

  @override
  setKey(String networkId, String accountId, KeyPair keyPair) {
    keys['$accountId:$networkId'] = keyPair.toString();
  }

}