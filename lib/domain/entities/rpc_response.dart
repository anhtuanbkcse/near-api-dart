import 'package:equatable/equatable.dart';

class RpcResponse<T> extends Equatable {
  final String jsonRpc;
  final T result;

  const RpcResponse ({
    required this.jsonRpc,
    required this.result,
  });


  @override
  List<Object?> get props => [jsonRpc, result];


  factory RpcResponse.fromJson(dynamic json) {
    return RpcResponse(
        jsonRpc : json['jsonrpc'],
        result: json['result']
    );
  }
}