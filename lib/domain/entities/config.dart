
import 'package:equatable/equatable.dart';
import 'package:near_api/provider/provider.dart';
import 'package:near_api/sign/signer.dart';

class Config extends Equatable {

  final String networkId;
  final String nodeUrl;
  final Map<String, String>? headers;
  final ProviderConfig? provider;
  final Signer? signer;
  final double? initialBalance;
  final String? helperUrl;
  final String? walletUrl;

  const Config ({required this.networkId, required this.nodeUrl, this.initialBalance, this.helperUrl, this.walletUrl, this.headers, this.provider, this.signer});

  @override
  List<Object?> get props => [networkId, nodeUrl, initialBalance, helperUrl];

}


class ProviderConfig {
  final String? type;
  final dynamic args;

  const ProviderConfig({required this.type, required this.args});
}