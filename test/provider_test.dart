
import 'package:flutter_test/flutter_test.dart';
import 'package:near_api/data/models/block_reference_request.dart';
import 'package:near_api/environment.dart';
import 'package:near_api/near_api.dart';

import 'dart:core';

import 'package:near_api/provider/json_rpc_provider.dart';
import 'package:near_api/provider/provider.dart';

void main() {

  Near near = Near.connect(Env.testNet);

  test("json rpc fetch protocol config", () async {
    var status = await near.connection.provider?.status();
    var blockHas = status!.data!.result.syncInfo.latestBlockHash;
    var testCases =
    [BlockReferenceRequest.fromBlockId(blockHas.toString()),
      BlockReferenceRequest.fromFinality(BlockReferenceRequest.finalityFinal), BlockReferenceRequest.fromFinality(BlockReferenceRequest.finalityOptimistic),
      BlockReferenceRequest.fromSyncCheckpoint(BlockReferenceRequest.syncCheckPointGenesis)];

    for (var request in testCases) {
      var response = await near.connection.provider?.experimentalProtocolConfig(request);
      expect(response?.data?.result["chain_id"] != null, true);
      expect(response?.data?.result["genesis_height"] != null, true);
      expect(response?.data?.result["runtime_config"] != null, true);
      expect(response?.data?.result["runtime_config"]['storage_amount_per_byte'] != null, true);
    }
  });

  test('json rpc gas price', () async {

    var status = await near.connection.provider?.status();
    expect(status?.data?.result.chainId, "testnet");

    var positiveIntegerRegex = r'(^\d*\.?\d*)';
    var regEx = RegExp(positiveIntegerRegex);

    var response1 = await near.connection.provider?.gasPrice(status!.data!.result.syncInfo.latestBlockHash);
    expect(regEx.hasMatch(response1!.data!.result.gasPrice), true);

    var response2 = await near.connection.provider?.gasPrice(status!.data!.result.syncInfo.earliestBlockHash);
    expect(regEx.hasMatch(response2!.data!.result.gasPrice), true);
  });

  test('JsonRpc connection object exist without url provided', () {
    JsonRpcProvider provider = JsonRpcProvider(null);
    expect(provider.connection?.url, null);
  });

  test('JsonRpc connection url is not null on empty string', () {
    JsonRpcProvider provider = JsonRpcProvider("");
    expect(provider.connection?.url, "");
  });

  test('Near json rpc fetch node status', () async {
    var result = await near.connection.provider?.status();
    expect(result?.data?.result.chainId, "testnet");
  });

}
