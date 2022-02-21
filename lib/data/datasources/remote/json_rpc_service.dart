



import 'package:dio/dio.dart';
import 'package:near_api/data/models/create_account_request.dart';
import 'package:near_api/data/models/gas_price_response.dart';
import 'package:near_api/data/models/node_status_response.dart';
import 'package:near_api/data/models/rpc_request_body.dart';
import 'package:near_api/domain/entities/rpc_response.dart';
import 'package:retrofit/retrofit.dart';

part 'json_rpc_service.g.dart';

@RestApi()
abstract class JsonRpcApiService {
  factory JsonRpcApiService(Dio dio, {String baseUrl}) = _JsonRpcApiService;

  @POST('')
  Future<HttpResponse<RpcResponse<dynamic>>> callApi ({
    @Body() RPCRequestBody? params
  });

  @POST('')
  Future<HttpResponse<NodeStatusResponse>> nodeStatus ({
    @Body() RPCRequestBody? params
  });

  @POST('')
  Future<HttpResponse<GasPriceResponse>> gasPrice ({
    @Body() RPCRequestBody? params
  });

  @POST('/account')
  Future<HttpResponse<dynamic>> callAccountApi ({
    @Body() RPCRequestBody? params
  });

  @POST('https://helper.nearprotocol.com/account')
  Future<HttpResponse<dynamic>> createAccount ({
    @Body() CreateAccountRequest? request
  });
}