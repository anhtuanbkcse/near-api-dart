library near_api;



import 'package:dio/dio.dart';
import 'package:near_api/core/resources/data_state.dart';
import 'package:near_api/injector.dart';
import 'package:near_api/utils/key_pair.dart';

import 'domain/entities/account.dart';
import 'domain/entities/connection.dart';
import 'domain/repositories/near_repository.dart';
import 'environment.dart';

class Near {

  Connection connection;
  String baseUrl;

  Near({required this.baseUrl, required this.connection});

  static Near connect(Env env) {
    initializeDependencies(env);
    Dio dio = injector();
    return Near(baseUrl: dio.options.baseUrl,connection: Connection.fromEnv(env, dio.options.baseUrl, "","") );
  }

  static Future<Near> connectAsync(Env env) async{
    initializeDependencies(env);
    Dio dio = injector();
    return Near(baseUrl: dio.options.baseUrl,connection: Connection.fromEnv(env, dio.options.baseUrl, "","") );
  }



  static KeyPair keyPairFromRandom(){
    return KeyPair.fromRandom("ed25519");
  }

  static KeyPair keyPairFromSeedPhrase(String seedPhrase) {
    return KeyPair.fromSeedPhrase("ed25519", seedPhrase);
  }


  static KeyPair keyPairFromSecretKey(String secretKey) {
    return KeyPair.fromString(secretKey);
  }




  Future<DataState<Account>> createAccount(String accountId, PublicKey publicKey) async {
    NearRepository repository = injector();
    return repository.createAccount(accountId, publicKey);
  }

}
