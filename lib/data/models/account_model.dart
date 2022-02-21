

import 'package:near_api/domain/entities/account.dart';

class AccountModel extends Account {
  const AccountModel({required String id}) : super(id: id);

  factory AccountModel.fromJson(dynamic json) {
    return AccountModel(
        id : json['id']
    );
  }
}