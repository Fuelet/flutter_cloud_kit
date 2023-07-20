//
//  GetAccountStatus.swift
//  flutter_cloud_kit
//
//  Created by Mikhail Poplavkov on 18.07.23.
//

import CloudKit
import Flutter

class GetAccountStatusHandler {
    static func handle(arguments: Dictionary<String, Any>, result: @escaping FlutterResult) -> Void {
        var container: CKContainer;
        if let containerId = arguments["containerId"] as? String {
            container = CKContainer(identifier: containerId)
        } else {
            container = CKContainer.default()
        }
        container.accountStatus { (accountStatus: CKAccountStatus, error: Error?) in
            if (error != nil) {
                result(FlutterError.init(code: "Error", message: error!.localizedDescription, details: nil))
                return
            }
            result(accountStatus.rawValue)
        }
    }
}
