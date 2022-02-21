

import 'package:near_api/utils/key_pair.dart';

abstract class KeyStore {
  setKey(String networkId, String accountId, KeyPair keyPair);
  KeyPair? getKey(String networkId, String accountId);
  removeKey(String networkId, String accountId);
  clear();
  List<String> getNetworks();
  List<String> getAccounts(String networkId);
}