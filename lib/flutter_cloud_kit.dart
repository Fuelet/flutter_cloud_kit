import 'package:flutter_cloud_kit/types/cloud_kit_account_status.dart';

import 'flutter_cloud_kit_platform_interface.dart';

class FlutterCloudKit {
  final String? containerId;

  FlutterCloudKit({this.containerId});

  Future<CloudKitAccountStatus> getAccountStatus() {
    return FlutterCloudKitPlatform.instance.getAccountStatus(this.containerId);
  }
}
