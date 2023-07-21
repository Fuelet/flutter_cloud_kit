import 'package:flutter/material.dart';
import 'package:flutter_cloud_kit/flutter_cloud_kit.dart';
import 'package:flutter_cloud_kit/types/cloud_kit_account_status.dart';
import 'package:flutter_cloud_kit/types/database_scope.dart';

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
  CloudKitAccountStatus? accountStatus;
  Map<String, dynamic>? fetchedRecord;

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
                    print('Successfully saved the record $record');
                  } catch (e) {
                    print('Failed to save the record: $e');
                  }
                },
                child: const Text('Save'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var name = recordName.text;
                  fetchedRecord = await cloudKit.getRecord(
                      scope: databaseScope, recordName: name);
                  print('Successfully got the record by name $name');
                },
                child: const Text('Get'),
              ),
              ElevatedButton(
                onPressed: () async {
                  print("Not implemented yet");
                },
                child: const Text('Delete'),
              ),
              ElevatedButton(
                onPressed: () async {
                  accountStatus = await cloudKit.getAccountStatus();
                  setState(() {});
                },
                child: const Text('Get account status'),
              ),
              (fetchedRecord != null)
                  ? Text(
                'Fetched record: $fetchedRecord',
                textAlign: TextAlign.center,
              )
                  : Container(),
              (accountStatus != null)
                  ? Text(
                'Current account status: $accountStatus',
                textAlign: TextAlign.center,
              )
                  : Container()
            ],
          )),
    );
  }
}
