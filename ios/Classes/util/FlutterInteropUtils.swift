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

func getContainerFromArgsOrDefault(arguments: Dictionary<String, Any>) -> CKContainer {
    if let containerId = arguments["containerId"] as? String {
        return CKContainer(identifier: containerId)
    } else {
        return CKContainer.default()
    }
}

func getRecordIdFromArgs(arguments: Dictionary<String, Any>) -> CKRecord.ID? {
    if let recordName = arguments["recordName"] as? String {
        return CKRecord.ID(recordName: recordName)
    } else {
        return nil
    }
}

func getRecordIdFromArgsOrDefault(arguments: Dictionary<String, Any>) -> CKRecord.ID {
    if let recordId = getRecordIdFromArgs(arguments: arguments) {
        return recordId
    } else {
        return CKRecord.ID()
    }
}

func getDatabaseFromArgs(arguments: Dictionary<String, Any>) -> CKDatabase? {
    let container = getContainerFromArgsOrDefault(arguments: arguments);
    if let databaseScope = arguments["databaseScope"] as? String {
        if databaseScope == "private" {
            return container.privateCloudDatabase;
        } else {
            // not supported
            return nil
        }
    } else {
        return nil
    }
}

func convertCkRecordType(value: __CKRecordObjCValue) -> Any? {
    if let str = value as? NSString {
        return str as String;
    } else if let num = value as? NSNumber {
        return num.stringValue;
    } else if let data = value as? NSData {
        return data.base64EncodedString();
    } else if let date = value as? NSDate {
        return date.timeIntervalSince1970;
    } else if let reference = value as? CKRecord.Reference {
        return reference.recordID.recordName;
    } else if let asset = value as? CKAsset {
        return asset.fileURL?.absoluteString;
    } else  {
        // not supported
        return nil;
    }
}

func recordToDictionary(record: CKRecord) -> Dictionary<String, Any?> {
    var dictionary: [String: Any?] = [:];
    
    dictionary["recordName"] = record.recordID.recordName;
    dictionary["recordType"] = record.recordType;
    
    for key in record.allKeys() {
        if let value = record[key] {
            dictionary[key] = convertCkRecordType(value: value);
        }
    }
    
    return dictionary;
}
