import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cloud_kit/types/cloud_kit_account_status.dart';
import 'package:flutter_cloud_kit/types/database_scope.dart';

import 'flutter_cloud_kit_platform_interface.dart';

/// An implementation of [FlutterCloudKitPlatform] that uses method channels.
class MethodChannelFlutterCloudKit extends FlutterCloudKitPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('app.fuelet.flutter_cloud_kit');

  @override
  Future<CloudKitAccountStatus> getAccountStatus({String? containerId}) async {
    final args = containerId == null ? {} : {'containerId': containerId};
    int rawStatus = await methodChannel.invokeMethod('getAccountStatus', args);
    try {
      return CloudKitAccountStatus.values[rawStatus];
    } catch (_) {
      return CloudKitAccountStatus.unknown;
    }
  }

  @override
  Future<void> saveRecord(
      {String? containerId,
      required CloudKitDatabaseScope scope,
      required String recordType,
      required Map<String, String> record,
      String? recordName}) async {
    var args = {
      'databaseScope': scope.name,
      'recordType': recordType,
      'record': record
    };
    if (containerId != null) {
      args['containerId'] = containerId;
    }
    if (recordName != null) {
      args['recordName'] = recordName;
    }
    await methodChannel.invokeMethod('saveRecord', args);
  }

  @override
  Future<Map<String, dynamic>> getRecord(
      {String? containerId,
      required CloudKitDatabaseScope scope,
      required String recordName}) async {
    var args = {
      'databaseScope': scope.name,
      'recordName': recordName,
    };
    if (containerId != null) {
      args['containerId'] = containerId;
    }
    return await methodChannel.invokeMethod('getRecord', args);
  }
}
