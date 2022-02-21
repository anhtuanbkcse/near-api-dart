

import 'dart:typed_data';

import 'package:near_api/core/resources/data_state.dart';
import 'package:near_api/data/models/block_reference_request.dart';
import 'package:near_api/data/models/gas_price_response.dart';
import 'package:near_api/data/models/node_status_response.dart';
import 'package:near_api/domain/entities/general_response.dart';
import 'package:near_api/domain/entities/rpc_response.dart';

abstract class Provider {

  final String type;
  dynamic args;

  Provider({required this.type, this.args});

  Future<DataState<NodeStatusResponse>> status();
  FinalExecutionOutcome sendTransaction(SignedTransaction signedTransaction);
  Future<FinalExecutionOutcome> sendTransactionAsync(SignedTransaction signedTransaction);
  FinalExecutionOutcome txStatus(Uint8List txHash, String accountId);
  FinalExecutionOutcome txStatusReceipts(Uint8List txHash, String accountId);
  T query<T extends QueryResponseKind>(RpcQueryRequest? params, String? path, String? data);
  BlockResult block(BlockId? blockId, BlockReferenceRequest? blockReference);
  BlockChangeResult blockChanges(BlockId? blockId, BlockReferenceRequest? blockReference);
  ChunkResult chunk(ChunkId chunkId);
  EpochValidatorInfo validators(BlockId blockId);
  NearProtocalConfig experimentalGenesisConfig();
  Future<DataState<RpcResponse<dynamic>>> experimentalProtocolConfig(dynamic blockReference);
  LightClientProof lightClientProof(LightClientProofRequest request);
  Future<DataState<GasPriceResponse>> gasPrice(String blockId);
  ChangeResult accessKeyChanges(List<String> accountIdArray, BlockId? blockId, BlockReferenceRequest? blockReference);
  ChangeResult singleAccessKeyChanges(List<AccessKeyWithPublicKey> accessKeyArray, BlockId blockId, BlockReferenceRequest blockReference);
  ChangeResult accountChanges(List<String> accountIdArray, BlockId? blockId, BlockReferenceRequest? blockReference);
  ChangeResult contractStateChanges(List<String> accountIdArray, BlockId? blockId, BlockReferenceRequest? blockReference, String keyPrefix);
  ChangeResult contractCodeChanges(List<String> accountIdArray, BlockId? blockId, BlockReferenceRequest? blockReference);
}

class ConnectionInfo {
  String url;
  String? user;
  String? password;
  bool? allowInsecure;
  int? timeout;
  dynamic headers;

  ConnectionInfo({required this.url, this.user, this.password, this.allowInsecure, this.headers});
}


class SignedTransaction {

}

class FinalExecutionOutcome {

}

class QueryResponseKind {

}

class RpcQueryRequest {

}

class BlockResult {

}

class BlockId {

}

class BlockChangeResult {

}

class ChunkId {

}

class ChunkResult {

}

class EpochValidatorInfo {

}

class NearProtocalConfig {

}

class LightClientProofRequest {

}

class LightClientProof {

}


class AccessKeyWithPublicKey {

}

class ChangeResult {

}