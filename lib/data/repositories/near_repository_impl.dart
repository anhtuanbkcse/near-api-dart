


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:near_api/core/resources/data_state.dart';
import 'package:near_api/data/datasources/remote/json_rpc_service.dart';
import 'package:near_api/data/models/create_account_request.dart';
import 'package:near_api/data/models/gas_price_response.dart';
import 'package:near_api/data/models/node_status_response.dart';
import 'package:near_api/domain/entities/account.dart';
import 'package:near_api/domain/entities/general_response.dart';
import 'package:near_api/data/models/rpc_request_body.dart';
import 'package:near_api/domain/entities/rpc_response.dart';
import 'package:near_api/domain/repositories/near_repository.dart';
import 'package:near_api/provider/provider.dart';
import 'package:near_api/utils/key_pair.dart';

class NearRepositoryImpl implements NearRepository {

  var currentId = 100;

  final JsonRpcApiService _apiServices;
  NearRepositoryImpl(this._apiServices);

  @override
  Future<DataState> connectWallet(RPCRequestBody params) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<Account>> createAccount(String accountId, PublicKey publicKey) async {
    try {
      currentId = currentId + 1;
      CreateAccountRequest body = CreateAccountRequest(newAccountId: accountId, newPublicKey: publicKey.toString());
      final httpResponse = await _apiServices.createAccount(request: body);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }


  @override
  Future<DataState<NodeStatusResponse>> status() async {
    try {
      currentId = currentId + 1;
      RPCRequestBody body = RPCRequestBody(method: "status", id: currentId, params: []);
      final httpResponse = await _apiServices.nodeStatus(params: body);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<GasPriceResponse>> gasPrice(String blockId) async {
    try {
      currentId = currentId + 1;
      RPCRequestBody body = RPCRequestBody(method: "gas_price", id: currentId, params: [blockId]);
      final httpResponse = await _apiServices.gasPrice(params: body);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<RpcResponse<dynamic>>> experimentalProtoColConfig(dynamic blockReference) async {
    try {
      currentId = currentId + 1;
      RPCRequestBody body = RPCRequestBody(method: "EXPERIMENTAL_protocol_config", id: currentId, params: blockReference);
      final httpResponse = await _apiServices.callApi(params: body);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

}