/// jsonrpc : "2.0"
/// result : "String"
/// id : 100

class GeneralResponse<T> {
  GeneralResponse({
      required this.jsonRpc,
      required this.result,
      required this.id,});

  String? jsonRpc;
  T? result;
  int? id;

}