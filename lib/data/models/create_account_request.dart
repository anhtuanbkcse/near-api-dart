
class CreateAccountRequest {

  final String newAccountId;
  final String newPublicKey;

  CreateAccountRequest({required this.newAccountId, required this.newPublicKey});

  Map<String, dynamic> toJson() {
    return {
      "newAccountId": newAccountId,
      "newAccountPublicKey": newPublicKey,
    };
  }
}