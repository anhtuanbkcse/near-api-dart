

import 'package:near_api/domain/entities/gas_price.dart';

class GasPriceModel extends GasPrice {
  const GasPriceModel({required String gasPrice}): super(gasPrice: gasPrice);

  factory GasPriceModel.fromJson(dynamic json) {
    return GasPriceModel(
      gasPrice: json["gas_price"]
    );
  }
}