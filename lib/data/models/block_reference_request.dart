

class BlockReferenceRequest {

  static String finalityOptimistic = 'optimistic';
  static String finalityNearFinal = 'near-final';
  static String finalityFinal = 'final';

  static String syncCheckPointGenesis = "genesis";
  static String syncCheckPointEarliestAvailable = "earliest_available";


  static dynamic fromBlockId(String blockId) {
    return {"block_id": blockId};
  }

  static dynamic fromFinality(String finality) {
    return {"finality": finality};
  }

  static dynamic fromSyncCheckpoint(String checkPoint) {
    return {"sync_checkpoint": checkPoint};
  }
}