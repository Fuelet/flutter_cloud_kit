import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cloud_kit/types/cloud_kit_account_status.dart';

import 'flutter_cloud_kit_platform_interface.dart';

/// An implementation of [FlutterCloudKitPlatform] that uses method channels.
class MethodChannelFlutterCloudKit extends FlutterCloudKitPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('app.fuelet.flutter_cloud_kit');

  @override
  Future<CloudKitAccountStatus> getAccountStatus(String? containerId) async {
    final args = containerId == null ? {} : {"containerId": containerId};
    int rawStatus = await methodChannel.invokeMethod('getAccountStatus', args);
    try {
      return CloudKitAccountStatus.values[rawStatus];
    } catch (_) {
      return CloudKitAccountStatus.unknown;
    }
  }
}
