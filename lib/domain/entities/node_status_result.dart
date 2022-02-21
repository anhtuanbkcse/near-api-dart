

import 'package:equatable/equatable.dart';

class NodeStatusResult extends Equatable {
  final String chainId;
  final SyncInfo syncInfo;
  const NodeStatusResult({required this.chainId, required this.syncInfo});

  @override
  List<Object?> get props => [chainId, syncInfo];
}

class SyncInfo extends Equatable {
  final String latestBlockHash;
  final int latestBlockHeight;
  final String latestStateRoot;
  final String latestBlockTime;
  final String earliestBlockHash;
  final int earliestBlockHeight;
  final String earliestBlockTime;
  final bool syncing;

  const SyncInfo({
    required this.latestBlockHash, required this.latestBlockHeight, required this.latestStateRoot,
    required this.latestBlockTime, required this.earliestBlockHash, required this.earliestBlockHeight,
    required this.earliestBlockTime, required this.syncing
  });

  @override
  List<Object?> get props => [latestBlockHash, latestBlockHeight, latestStateRoot, latestBlockTime, earliestBlockHash, earliestBlockHeight, earliestBlockTime, syncing];
}

