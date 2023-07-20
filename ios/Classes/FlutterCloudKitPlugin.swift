import Flutter
import UIKit

public class FlutterCloudKitPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "app.fuelet.flutter_cloud_kit", binaryMessenger: registrar.messenger())
        let instance = FlutterCloudKitPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let callArguments: Dictionary<String, Any> = call.arguments as! Dictionary<String, Any>
        
        if (call.method == "getAccountStatus") {
            GetAccountStatusHandler.handle(arguments: callArguments, result: result)
        } else {
            result(FlutterError.init(code: "Error", message: "Not implemented", details: nil))
        }
    }
}
