//
//  GetRecordHandler.swift
//  flutter_cloud_kit
//
//  Created by Mikhail Poplavkov on 20.07.23.
//

import CloudKit
import Flutter

class GetRecordHandler {
    static func handle(arguments: Dictionary<String, Any>, result: @escaping FlutterResult) -> Void {
        let database: CKDatabase;
        if let databaseOpt = getDatabaseFromArgs(arguments: arguments) {
            database = databaseOpt;
        } else {
            return result(createFlutterError(message: "Cannot create a database for the provided scope"));
        }
        
        let recordId: CKRecord.ID;
        if let recordIdOpt = getRecordIdFromArgs(arguments: arguments) {
            recordId = recordIdOpt;
        } else {
            return result(createFlutterError(message: "Cannot parse record id"));
        }
        
        database.fetch(withRecordID: recordId) { (record, error) in
            if (error != nil) {
                return result(createFlutterError(message: error!.localizedDescription));
            }
            if (record == nil) {
                return result(createFlutterError(message: "Got nil when fetching the record"));
            } else {
                let dict = recordToDictionary(record: record!);
                return result(dict);
            }
        }
    }
}
