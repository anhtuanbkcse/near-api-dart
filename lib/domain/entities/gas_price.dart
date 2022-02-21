

import 'package:equatable/equatable.dart';

class GasPrice extends Equatable {

  final String gasPrice;
  const GasPrice({required this.gasPrice});

  @override
  List<Object?> get props => [gasPrice];

}