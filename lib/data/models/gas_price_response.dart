import 'package:near_api/data/models/gas_price_model.dart';
import 'package:near_api/domain/entities/gas_price.dart';
import 'package:near_api/domain/entities/rpc_response.dart';

class GasPriceResponse extends RpcResponse<GasPrice> {
  const GasPriceResponse ({
    required String jsonRpc,
    required GasPrice result,
  }) : super(jsonRpc: jsonRpc, result: result);

  factory GasPriceResponse.fromJson(dynamic json) {
    return GasPriceResponse(
        jsonRpc : json['jsonrpc'],
        result: GasPriceModel.fromJson(json['result'])
    );
  }

}