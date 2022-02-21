

import 'package:near_api/domain/entities/config.dart';
import 'package:near_api/provider/json_rpc_provider.dart';
import 'package:near_api/provider/provider.dart';
import 'package:near_api/sign/signer.dart';

import '../../environment.dart';
import '../../sign/in_memory_signer.dart';


Provider? getProvider(ProviderConfig? provider) {

  switch(provider?.type) {
    case 'JsonRpcProvider':
      return JsonRpcProvider(provider!.args);
    default:
      throw Error();
  }
}

Signer? getSigner(Signer? signer) {
  switch(signer?.type) {
    case 'InMemorySigner':
      return InMemorySigner(signer!.keyStore);
    default:
      return signer;
  }
}

class Connection {
  final String networkId;
  final Provider? provider;
  final Signer? signer;

  Connection({required this.networkId, required this.provider, required this.signer});


  static Connection fromConfig(Config config){
    Provider? provider = getProvider(config.provider);
    Signer? signer = getSigner(config.signer);
    return Connection(networkId: config.networkId, provider: provider, signer: signer);
  }

  static Connection fromEnv(Env env, String url, String user, String password) {
    Config? config;
    var provider = ProviderConfig(type: "JsonRpcProvider", args: ConnectionInfo(url: url, user: user, password: password, allowInsecure: false ));
    switch(env) {
      case Env.mainNet:
        config = Config(
          networkId: "mainnet",
          nodeUrl: "https://rpc.mainnet.near.org",
          walletUrl: "https://wallet.near.org",
          helperUrl: "https://helper.mainnet.near.org",
          provider: provider
        );
        break;
      case Env.testNet:
        config = Config(
            networkId: "testnet",
            nodeUrl: "https://rpc.testnet.near.org",
            walletUrl: "https://wallet.testnet.near.org",
            helperUrl: "https://helper.testnet.near.org",
            provider: provider
        );
        break;
      case Env.betaNet:
        config = Config(
            networkId: "betanet",
            nodeUrl: "https://rpc.betanet.near.org",
            walletUrl: "https://wallet.betanet.near.org",
            helperUrl: "https://helper.betanet.near.org",
            provider: provider
        );
        break;
      case Env.localHost:
        config = Config(
            networkId: "local",
            nodeUrl: "http://localhost:3030",
            walletUrl: "http://localhost:4000/wallet",
            provider: provider
        );
        break;
      default:
        throw Error();
    }
    return fromConfig(config);
  }
}