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

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
