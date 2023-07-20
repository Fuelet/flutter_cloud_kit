//
//  FlutterInteropUtils.swift
//  flutter_cloud_kit
//
//  Created by Mikhail Poplavkov on 20.07.23.
//

import Flutter
import CloudKit

func createFlutterError(message: String) -> FlutterError {
    return FlutterError.init(code: "Error", message: message, details: nil)
}

func extractContainerFromArgsOrDefault(arguments: Dictionary<String, Any>) -> CKContainer {
    if let containerId = arguments["containerId"] as? String {
        return CKContainer(identifier: containerId)
    } else {
        return CKContainer.default()
    }
}

func extractRecordIdFromArgsOrDefault(arguments: Dictionary<String, Any>) -> CKRecord.ID {
    if let recordName = arguments["recordName"] as? String {
        return CKRecord.ID(recordName: recordName)
    } else {
        return CKRecord.ID()
    }
}
