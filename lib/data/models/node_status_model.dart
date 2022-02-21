

import 'package:near_api/domain/entities/node_status_result.dart';

class NodeStatusModel extends NodeStatusResult {
  const NodeStatusModel({required String chainId, required SyncInfoModel syncInfo}) : super(chainId: chainId, syncInfo: syncInfo);

  factory NodeStatusModel.fromJson(dynamic json) {
    return NodeStatusModel(
        chainId: json['chain_id'],
        syncInfo: SyncInfoModel.fromJson(json["sync_info"])
    );
  }

}

class SyncInfoModel extends SyncInfo {
  const SyncInfoModel({
    required String latestBlockHash, required int latestBlockHeight, required String latestStateRoot,
    required String latestBlockTime, required String earliestBlockHash, required int earliestBlockHeight,
    required String earliestBlockTime, required bool syncing
  }): super(latestBlockHash: latestBlockHash, latestBlockHeight: latestBlockHeight, latestBlockTime: latestBlockTime, latestStateRoot: latestStateRoot,
      earliestBlockHash: earliestBlockHash, earliestBlockHeight: earliestBlockHeight, earliestBlockTime: earliestBlockTime, syncing: syncing
    );

  factory SyncInfoModel.fromJson(dynamic json) {
    return SyncInfoModel(
      latestBlockHash: json['latest_block_hash'],
      latestBlockHeight: json['latest_block_height'],
      latestStateRoot: json['latest_state_root'],
      latestBlockTime: json['latest_block_time'],
      earliestBlockHash: json['earliest_block_hash'],
      earliestBlockHeight: json['earliest_block_height'],
      earliestBlockTime: json['earliest_block_time'],
      syncing: json['syncing'],
    );
  }
}