

import 'package:near_api/data/models/node_status_model.dart';
import 'package:near_api/domain/entities/node_status_result.dart';
import 'package:near_api/domain/entities/rpc_response.dart';

class NodeStatusResponse extends RpcResponse<NodeStatusResult> {
  const NodeStatusResponse ({
    required String jsonRpc,
    required NodeStatusResult result,
  }) : super(jsonRpc: jsonRpc, result: result);

  factory NodeStatusResponse.fromJson(dynamic json) {
    return NodeStatusResponse(
        jsonRpc : json['jsonrpc'],
        result: NodeStatusModel.fromJson(json['result'])
    );
  }

}