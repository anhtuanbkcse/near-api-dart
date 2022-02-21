

import 'dart:typed_data';

import 'package:near_api/core/resources/data_state.dart';
import 'package:near_api/data/models/block_reference_request.dart';
import 'package:near_api/data/models/gas_price_response.dart';
import 'package:near_api/data/models/node_status_response.dart';
import 'package:near_api/domain/entities/general_response.dart';
import 'package:near_api/domain/entities/rpc_response.dart';
import 'package:near_api/domain/repositories/near_repository.dart';
import 'package:near_api/injector.dart';
import 'package:near_api/provider/provider.dart';

class JsonRpcProvider extends Provider {

  ConnectionInfo? connection;

  JsonRpcProvider(dynamic args) : super(type: 'JsonRpcProvider'){
    if (args is ConnectionInfo){
      connection = args;
    } else if (args is String){
      connection = ConnectionInfo(url: args);
    }
  }

  @override
  ChangeResult accessKeyChanges(List<String> accountIdArray, BlockId? blockId, BlockReferenceRequest? blockReference) {
    // TODO: implement accessKeyChanges
    throw UnimplementedError();
  }

  @override
  ChangeResult accountChanges(List<String> accountIdArray, BlockId? blockId, BlockReferenceRequest? blockReference) {
    // TODO: implement accountChanges
    throw UnimplementedError();
  }

  @override
  BlockResult block(BlockId? blockId, BlockReferenceRequest? blockReference) {
    // TODO: implement block
    throw UnimplementedError();
  }

  @override
  BlockChangeResult blockChanges(BlockId? blockId, BlockReferenceRequest? blockReference) {
    // TODO: implement blockChanges
    throw UnimplementedError();
  }

  @override
  ChunkResult chunk(ChunkId chunkId) {
    // TODO: implement chunk
    throw UnimplementedError();
  }

  @override
  ChangeResult contractCodeChanges(List<String> accountIdArray, BlockId? blockId, BlockReferenceRequest? blockReference) {
    // TODO: implement contractCodeChanges
    throw UnimplementedError();
  }

  @override
  ChangeResult contractStateChanges(List<String> accountIdArray, BlockId? blockId, BlockReferenceRequest? blockReference, String keyPrefix) {
    // TODO: implement contractStateChanges
    throw UnimplementedError();
  }

  @override
  NearProtocalConfig experimentalGenesisConfig() {
    // TODO: implement experimentalGenesisConfig
    throw UnimplementedError();
  }

  @override
  Future<DataState<RpcResponse<dynamic>>> experimentalProtocolConfig(dynamic blockReference) {
    NearRepository nearRepository = injector();
    return nearRepository.experimentalProtoColConfig(blockReference);
  }

  @override
  Future<DataState<GasPriceResponse>> gasPrice(String blockId) {
    NearRepository nearRepository = injector();
    return nearRepository.gasPrice(blockId);
  }

  @override
  LightClientProof lightClientProof(LightClientProofRequest request) {
    // TODO: implement lightClientProof
    throw UnimplementedError();
  }

  @override
  T query<T extends QueryResponseKind>(RpcQueryRequest? params, String? path, String? data) {
    // TODO: implement query
    throw UnimplementedError();
  }

  @override
  FinalExecutionOutcome sendTransaction(SignedTransaction signedTransaction) {
    // TODO: implement sendTransaction
    throw UnimplementedError();
  }

  @override
  Future<FinalExecutionOutcome> sendTransactionAsync(SignedTransaction signedTransaction) {
    // TODO: implement sendTransactionAsync
    throw UnimplementedError();
  }

  @override
  ChangeResult singleAccessKeyChanges(List<AccessKeyWithPublicKey> accessKeyArray, BlockId blockId, BlockReferenceRequest blockReference) {
    // TODO: implement singleAccessKeyChanges
    throw UnimplementedError();
  }

  @override
  Future<DataState<NodeStatusResponse>> status() {
    NearRepository nearRepository = injector();
    return nearRepository.status();
  }

  @override
  FinalExecutionOutcome txStatus(Uint8List txHash, String accountId) {
    // TODO: implement txStatus
    throw UnimplementedError();
  }

  @override
  FinalExecutionOutcome txStatusReceipts(Uint8List txHash, String accountId) {
    // TODO: implement txStatusReceipts
    throw UnimplementedError();
  }

  @override
  EpochValidatorInfo validators(BlockId blockId) {
    // TODO: implement validators
    throw UnimplementedError();
  }

}