import Flutter
import UIKit

public class FlutterCloudKitPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "app.fuelet.flutter_cloud_kit", binaryMessenger: registrar.messenger())
        let instance = FlutterCloudKitPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    // TODO: handle ObjectiveC exceptions
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let callArguments: Dictionary<String, Any> = call.arguments as! Dictionary<String, Any>
        
        if (call.method == "getAccountStatus") {
            return GetAccountStatusHandler.handle(arguments: callArguments, result: result);
        } else if (call.method == "saveRecord") {
            return SaveRecordHandler.handle(arguments: callArguments, result: result);
        } else if (call.method == "getRecord") {
            return GetRecordHandler.handle(arguments: callArguments, result: result);
        } else {
            return result(createFlutterError(message: "Not implemented"));
        }
    }
}
