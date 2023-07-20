//
//  SaveRecordHandler.swift
//  flutter_cloud_kit
//
//  Created by Mikhail Poplavkov on 20.07.23.
//

import CloudKit
import Flutter

class SaveRecordHandler {
    static func handle(arguments: Dictionary<String, Any>, result: @escaping FlutterResult) -> Void {
        let container = extractContainerFromArgsOrDefault(arguments: arguments);
        
        if let databaseScope = arguments["databaseScope"] as? String,
           let recordType = arguments["recordType"] as? String,
           let recordValues = arguments["record"] as? Dictionary<String, String> {
            var database: CKDatabase;
            if databaseScope == "private" {
                database = container.privateCloudDatabase;
            } else {
                result(createFlutterError(message: "Database scope " + databaseScope + " is not supported"))
                return
            }
            
            let recordId = extractRecordIdFromArgsOrDefault(arguments: arguments);
            let record = CKRecord(recordType: recordType, recordID: recordId)
            
            // TODO: handle ObjectiveC exceptions
            record.setValuesForKeys(recordValues)

            database.save(record) { (record, error) in
                if (error != nil) {
                    result(createFlutterError(message: error!.localizedDescription))
                    return
                }
                if (record == nil) {
                    result(createFlutterError(message: "Got nil while saving the record"))
                    return
                }
                result(true)
            }
        } else {
            result(createFlutterError(message: "Couldn't parse required parameters"))
        }
    }
}
