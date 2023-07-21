import 'package:flutter_cloud_kit/types/cloud_kit_account_status.dart';
import 'package:flutter_cloud_kit/types/database_scope.dart';

import 'flutter_cloud_kit_platform_interface.dart';

class FlutterCloudKit {
  final String? containerId;

  FlutterCloudKit({this.containerId});

  Future<CloudKitAccountStatus> getAccountStatus() {
    return FlutterCloudKitPlatform.instance
        .getAccountStatus(containerId: containerId);
  }

  Future<void> saveRecord(
      {required CloudKitDatabaseScope scope,
      required String recordType,
      required Map<String, String> record,
      String? recordName}) {
    return FlutterCloudKitPlatform.instance.saveRecord(
        containerId: containerId,
        scope: scope,
        recordType: recordType,
        record: record,
        recordName: recordName);
  }

  Future<Map<String, dynamic>> getRecord(
      {required CloudKitDatabaseScope scope, required String recordName}) {
    return FlutterCloudKitPlatform.instance.getRecord(
        containerId: containerId, scope: scope, recordName: recordName);
  }

  Future<void> deleteRecord(
      {required CloudKitDatabaseScope scope, required String recordName}) {
    return FlutterCloudKitPlatform.instance.deleteRecord(
        containerId: containerId, scope: scope, recordName: recordName);
  }
}
