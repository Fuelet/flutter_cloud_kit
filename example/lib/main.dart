import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_kit/flutter_cloud_kit.dart';
import 'package:flutter_cloud_kit/types/cloud_ket_record.dart';
import 'package:flutter_cloud_kit/types/database_scope.dart';
import 'package:fluttertoast/fluttertoast.dart';

const exampleContainerId = "iCloud.flutter_cloud_kit_example";
const exampleRecordType = "ExampleRecordType";
const databaseScope = CloudKitDatabaseScope.private;

void main() {
  runApp(const FlutterCloudKitExample());
}

class FlutterCloudKitExample extends StatefulWidget {
  const FlutterCloudKitExample({super.key});

  @override
  State<FlutterCloudKitExample> createState() => _FlutterCloudKitExampleState();
}

class _FlutterCloudKitExampleState extends State<FlutterCloudKitExample> {
  TextEditingController recordName = TextEditingController();
  TextEditingController key = TextEditingController();
  TextEditingController value = TextEditingController();
  FlutterCloudKit cloudKit = FlutterCloudKit(containerId: exampleContainerId);
  List<String> fetchedRecordsText = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter cloud kit example'),
          ),
          body: Column(
            children: [
              TextFormField(
                controller: recordName,
                decoration: const InputDecoration(hintText: 'Record name'),
              ),
              TextFormField(
                controller: key,
                decoration: const InputDecoration(hintText: 'Key'),
              ),
              TextFormField(
                controller: value,
                decoration: const InputDecoration(hintText: 'Value'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var record = {key.text: value.text};
                  try {
                    await cloudKit.saveRecord(
                        scope: databaseScope,
                        recordType: exampleRecordType,
                        record: record,
                        recordName: recordName.text);
                    _debugMessage('Successfully saved the record $record');
                  } catch (e) {
                    _debugMessage('Failed to save the record: $e');
                  }
                },
                child: const Text('Save'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var name = recordName.text;
                  try {
                    var fetchedRecord = await cloudKit.getRecord(
                        scope: databaseScope, recordName: name);
                    fetchedRecordsText = [
                      'Fetched record:',
                      _recordToString(fetchedRecord)
                    ];
                    _debugMessage('Successfully got the record by name $name');
                    setState(() {});
                  } catch (e) {
                    _debugMessage('Error getting record by name $name: $e');
                  }
                },
                child: const Text('Get'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    var fetchedRecordsByType = await cloudKit.getRecordsByType(
                        scope: databaseScope, recordType: exampleRecordType);
                    fetchedRecordsText = ['Fetched records:'];
                    fetchedRecordsText.addAll(
                        fetchedRecordsByType.map((e) => _recordToString(e)));
                    _debugMessage(
                        'Successfully got ${fetchedRecordsByType.length} records by type');
                    setState(() {});
                  } catch (e) {
                    _debugMessage("Error getting records by type: $e");
                  }
                },
                child: const Text('Get all records by type'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var name = recordName.text;
                  try {
                    await cloudKit.deleteRecord(
                        scope: databaseScope, recordName: name);
                    _debugMessage('Successfully deleted record by name $name');
                  } catch (e) {
                    _debugMessage('Error deleting the record $name: $e');
                  }
                },
                child: const Text('Delete'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var accountStatus = await cloudKit.getAccountStatus();
                  _debugMessage('Current account status: $accountStatus');
                },
                child: const Text('Get account status'),
              ),
              Column(
                  children: fetchedRecordsText
                      .map((e) => Text(e, textAlign: TextAlign.center))
                      .toList()),
            ],
          )),
    );
  }
}

void _debugMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.black,
    textColor: Colors.white,
  );
  print(message);
}

String _recordToString(CloudKitRecord record) {
  var obj = {
    'recordType': record.recordType,
    'recordName': record.recordName,
    'values': record.values
  };
  return jsonEncode(obj);
}
