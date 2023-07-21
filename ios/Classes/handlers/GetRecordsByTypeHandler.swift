//
//  GetRecordsByTypeHandler.swift
//  flutter_cloud_kit
//
//  Created by Mikhail Poplavkov on 21.07.23.
//


import CloudKit
import Flutter

class GetRecordsByTypeHandler {
    static func handle(arguments: Dictionary<String, Any>, result: @escaping FlutterResult) -> Void {
        let database: CKDatabase;
        let recordType: String;
        
        if let databaseOpt = getDatabaseFromArgs(arguments: arguments) {
            database = databaseOpt;
        } else {
            return result(createFlutterError(message: "Cannot create a database for the provided scope"));
        }
        
        if let recordTypeOpt = getRecordTypeFromArgs(arguments: arguments) {
            recordType = recordTypeOpt;
        } else {
            return result(createFlutterError(message: "Couldn't parse the required parameter 'recordType'"));
        }
        
        let predicate = NSPredicate(value: true);
        // TODO: make sort to be custom
        let sort = NSSortDescriptor(key: "creationDate", ascending: true);
        let query = CKQuery(recordType: recordType, predicate: predicate);
        query.sortDescriptors = [sort];
        
        // TODO: add pagination
        // TODO: add ability to specify desired keys
        database.perform(query, inZoneWith: nil) { (records: [CKRecord]?, error: Error?) in
            if (error != nil) {
                return result(createFlutterError(message: error!.localizedDescription));
            }
            if (records == nil) {
                return result([:]);
            } else {
                let transformed = records!.map(recordToDictionary);
                return result(transformed);
            }
        }
    }
}
