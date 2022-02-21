

import 'package:near_api/core/resources/data_state.dart';
import 'package:near_api/data/models/gas_price_response.dart';
import 'package:near_api/data/models/node_status_response.dart';
import 'package:near_api/domain/entities/account.dart';
import 'package:near_api/domain/entities/general_response.dart';
import 'package:near_api/data/models/rpc_request_body.dart';
import 'package:near_api/domain/entities/rpc_response.dart';
import 'package:near_api/provider/provider.dart';
import 'package:near_api/utils/key_pair.dart';

abstract class NearRepository {
  Future<DataState<Account>> createAccount(String accountId, PublicKey publicKey);

  Future<DataState<dynamic>> connectWallet(RPCRequestBody params);

  Future<DataState<NodeStatusResponse>> status();

  Future<DataState<GasPriceResponse>> gasPrice(String blockId);

  Future<DataState<RpcResponse<dynamic>>> experimentalProtoColConfig(dynamic blockReference);
}