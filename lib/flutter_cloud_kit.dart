import 'package:flutter_cloud_kit/types/cloud_kit_account_status.dart';

import 'flutter_cloud_kit_platform_interface.dart';

class FlutterCloudKit {
  Future<CloudKitAccountStatus> getAccountStatus(String containerId) {
    return FlutterCloudKitPlatform.instance.getAccountStatus(containerId);
  }
}
