import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_cloud_kit/flutter_cloud_kit_method_channel.dart';

void main() {
  MethodChannelFlutterCloudKit platform = MethodChannelFlutterCloudKit();
  const MethodChannel channel = MethodChannel('flutter_cloud_kit');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
