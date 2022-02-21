

class RPCRequestBody {

  String method;
  int id;
  String jsonRPCVersion = "2.0";
  dynamic params;

  RPCRequestBody({required this.method, required this.id, required this.params});

  Map<String, dynamic> toJson() {
    return {
      "method": method,
      "id": id,
      "jsonrpc": jsonRPCVersion,
      "params" : params
    };
  }
}