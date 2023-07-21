import 'package:flutter_cloud_kit/types/cloud_ket_record.dart';
import 'package:flutter_cloud_kit/types/cloud_kit_account_status.dart';
import 'package:flutter_cloud_kit/types/database_scope.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_cloud_kit_method_channel.dart';

abstract class FlutterCloudKitPlatform extends PlatformInterface {
  /// Constructs a FlutterCloudKitPlatform.
  FlutterCloudKitPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterCloudKitPlatform _instance = MethodChannelFlutterCloudKit();

  /// The default instance of [FlutterCloudKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterCloudKit].
  static FlutterCloudKitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterCloudKitPlatform] when
  /// they register themselves.
  static set instance(FlutterCloudKitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<CloudKitAccountStatus> getAccountStatus({String? containerId}) {
    throw UnimplementedError('getAccountStatus() has not been implemented.');
  }

  Future<void> saveRecord(
      {String? containerId,
      required CloudKitDatabaseScope scope,
      required String recordType,
      required Map<String, String> record,
      String? recordName}) {
    throw UnimplementedError('saveRecord() has not been implemented.');
  }

  Future<CloudKitRecord> getRecord(
      {String? containerId,
      required CloudKitDatabaseScope scope,
      required String recordName}) {
    throw UnimplementedError('getRecord() has not been implemented.');
  }

  Future<void> deleteRecord(
      {String? containerId,
      required CloudKitDatabaseScope scope,
      required String recordName}) {
    throw UnimplementedError('deleteRecord() has not been implemented.');
  }
}
