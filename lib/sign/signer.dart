

import 'package:near_api/keystore/keystore.dart';
import 'package:near_api/sign/signed_message.dart';
import 'package:near_api/utils/key_pair.dart';

abstract class Signer {

  final String type;
  final KeyStore keyStore;

  const Signer({required this.type, required this.keyStore});

  PublicKey createKey(String accountId, String networkId);

  PublicKey? getPublicKey(String accountId, String networkId);

  SignedMessage signMessage(String message, String accountId, String networkId);

}