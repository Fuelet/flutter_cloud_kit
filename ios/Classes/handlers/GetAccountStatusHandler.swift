//
//  GetAccountStatusHandler.swift
//  flutter_cloud_kit
//
//  Created by Mikhail Poplavkov on 18.07.23.
//

import CloudKit
import Flutter

class GetAccountStatusHandler {
    static func handle(arguments: Dictionary<String, Any>, result: @escaping FlutterResult) -> Void {
        let container = getContainerFromArgsOrDefault(arguments: arguments);
        container.accountStatus { (accountStatus: CKAccountStatus, error: Error?) in
            if (error != nil) {
                return result(createFlutterError(message: error!.localizedDescription));
            }
            return result(accountStatus.rawValue);
        }
    }
}
