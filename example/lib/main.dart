import 'package:flutter/material.dart';
import 'package:flutter_cloud_kit/flutter_cloud_kit.dart';
import 'package:flutter_cloud_kit/types/cloud_kit_account_status.dart';

const exampleContainerId = "app.fuelet.flutter_cloud_kit.example";

void main() {
  runApp(const FlutterCloudKitExample());
}

class FlutterCloudKitExample extends StatefulWidget {
  const FlutterCloudKitExample({super.key});

  @override
  State<FlutterCloudKitExample> createState() => _FlutterCloudKitExampleState();
}

class _FlutterCloudKitExampleState extends State<FlutterCloudKitExample> {
  TextEditingController key = TextEditingController();
  TextEditingController value = TextEditingController();
  FlutterCloudKit cloudKit = FlutterCloudKit();
  CloudKitAccountStatus? accountStatus;

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
                controller: key,
                decoration: const InputDecoration(hintText: 'Key'),
              ),
              TextFormField(
                controller: value,
                decoration: const InputDecoration(hintText: 'Value'),
              ),
              ElevatedButton(
                onPressed: () async {
                  print("Not implemented yet");
                },
                child: const Text('Save'),
              ),
              ElevatedButton(
                onPressed: () async {
                  print("Not implemented yet");
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
                  accountStatus =
                      await cloudKit.getAccountStatus(exampleContainerId);
                  setState(() {});
                },
                child: const Text('Get account status'),
              ),
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
