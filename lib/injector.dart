

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:near_api/data/datasources/remote/json_rpc_service.dart';
import 'package:near_api/data/repositories/near_repository_impl.dart';
import 'package:near_api/domain/repositories/near_repository.dart';

import 'consts.dart';
import 'environment.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies(Env env) async {
  String baseURL = ApiConfig.kMainNetUrl;
  switch(env) {
    case Env.mainNet:
      baseURL = ApiConfig.kMainNetUrl;
      break;
    case Env.testNet:
      baseURL = ApiConfig.kTestNetUrl;
      break;
    case Env.betaNet:
      baseURL = ApiConfig.kBetaNetUrl;
      break;
    case Env.localHost:
      baseURL = ApiConfig.kLocalHostUrl;
      break;
  }

  BaseOptions options = BaseOptions(
    baseUrl: baseURL,
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    // ignore: missing_return
  );
  Dio dio = Dio(options);
  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  injector.registerSingleton<Dio>(dio);

  injector.registerSingleton<JsonRpcApiService>(JsonRpcApiService(injector(), baseUrl: baseURL));

  injector.registerSingleton<NearRepository>(NearRepositoryImpl(injector()));
}