//
//  DeleteRecordHandler.swift
//  flutter_cloud_kit
//
//  Created by Mikhail Poplavkov on 20.07.23.
//

import CloudKit

#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#endif

class DeleteRecordHandler {
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
        
        database.delete(withRecordID: recordId) { (recordId, error) in
            if (error != nil) {
                return result(createFlutterError(message: error!.localizedDescription));
            }
            if (recordId == nil) {
                return result(createFlutterError(message: "Record was not found"));
            } else {
                return result(true);
            }
        }
    }
}
