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
        let database: CKDatabase;
        if let databaseOpt = getDatabaseFromArgs(arguments: arguments) {
            database = databaseOpt;
        } else {
            return result(createFlutterError(message: "Cannot create a database for the provided scope"));
        }
        
        if let recordType = arguments["recordType"] as? String,
           let recordValues = arguments["record"] as? Dictionary<String, String> {
            let recordId = getRecordIdFromArgsOrDefault(arguments: arguments);
            let record = CKRecord(recordType: recordType, recordID: recordId);
            
            // TODO: handle ObjectiveC exceptions
            record.setValuesForKeys(recordValues);
            
            database.save(record) { (record, error) in
                if (error != nil) {
                    return result(createFlutterError(message: error!.localizedDescription));
                }
                if (record == nil) {
                    return result(createFlutterError(message: "Got nil while saving the record"));
                }
                return result(true);
            }
        } else {
            return result(createFlutterError(message: "Couldn't parse required parameters"));
        }
    }
}
