import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cloud_kit/types/cloud_kit_account_status.dart';

import 'flutter_cloud_kit_platform_interface.dart';

/// An implementation of [FlutterCloudKitPlatform] that uses method channels.
class MethodChannelFlutterCloudKit extends FlutterCloudKitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app.fuelet.flutter_cloud_kit');

  @override
  Future<CloudKitAccountStatus> getAccountStatus(String containerId) async {
    int rawStatus = await methodChannel
        .invokeMethod('getAccountStatus', {"containerId": containerId});
    try {
      return CloudKitAccountStatus.values[rawStatus];
    } catch (_) {
      return CloudKitAccountStatus.unknown;
    }
  }
}
