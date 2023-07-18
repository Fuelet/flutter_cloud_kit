import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_cloud_kit/flutter_cloud_kit.dart';
import 'package:flutter_cloud_kit/flutter_cloud_kit_platform_interface.dart';
import 'package:flutter_cloud_kit/flutter_cloud_kit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterCloudKitPlatform
    with MockPlatformInterfaceMixin
    implements FlutterCloudKitPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterCloudKitPlatform initialPlatform = FlutterCloudKitPlatform.instance;

  test('$MethodChannelFlutterCloudKit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterCloudKit>());
  });

  test('getPlatformVersion', () async {
    FlutterCloudKit flutterCloudKitPlugin = FlutterCloudKit();
    MockFlutterCloudKitPlatform fakePlatform = MockFlutterCloudKitPlatform();
    FlutterCloudKitPlatform.instance = fakePlatform;

    expect(await flutterCloudKitPlugin.getPlatformVersion(), '42');
  });
}
