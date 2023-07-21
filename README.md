# flutter_cloud_kit

A simple flutter plugin for interactions with Apple Cloud Kit API on iOS devices.

Currently, the following functionality is supported:
- *getAccountStatus* - getting status of the user account;
- *saveRecord* - saving records;
- *getRecord* - getting records by key;
- *getRecordsByType* - getting records by type;
- *deleteRecord* - deleting record by key.

## Usage

### Creating an  instance of the FlutterCloudKit class
```dart
FlutterCloudKit cloudKit = FlutterCloudKit(containerId: exampleContainerId);
```

`containerId` parameter is optional. When not provided, the default container will be used.

### Getting account status
```dart
CloudKitAccountStatus accountStatus = await cloudKit.getAccountStatus();
```

### Saving a record
```dart
await cloudKit.saveRecord(scope: CloudKitDatabaseScope.private, recordType: exampleRecordType, record: {'fieldName': 'fieldValue'}, recordName: 'RecordName');
```

### Getting a record
```dart
CloudKitRecord record = await cloudKit.getRecord(scope: CloudKitDatabaseScope.private, recordName: 'RecordName');
```

### Getting records by type
```dart
List<CloudKitRecord> records = await cloudKit.getRecordsByType(scope: CloudKitDatabaseScope.private, recordType: exampleRecordType);
```

### Deleting a record
```dart
await cloudKit.deleteRecord(scope: CloudKitDatabaseScope.private, recordName: 'RecordName');
```

## Setup
See [Enabling CloudKit in Your App](https://developer.apple.com/documentation/cloudkit/enabling_cloudkit_in_your_app).

Basically, before you start using the plugin, you need to:
- Add the iCloud Capability to Your Xcode Project;
- Create a container you're going to use in Xcode;
- Select the CloudKit checkbox;
- Check the box next to the container name;

Also, in order to be able to retrieve records by type, you will need to add some indexes to the CloudKit database.

See [Enable Querying for Your Record Type](https://developer.apple.com/documentation/cloudkit/managing_icloud_containers_with_the_cloudkit_database_app/inspecting_and_editing_an_icloud_container_s_schema#3404860).

For every new record type you'll need to do the following:
1. Create the first record of this type;
2. Go to the [CloudKit Console](https://icloud.developer.apple.com/dashboard/);
3. Select your database;
4. Go to the *Indexes*;
5. Select your record type;
6. Click *Add Basic Index* and create two indexes:
   * `FIELD`: `recordName` and `Index Type`: `QUERYABLE` (needed to fetch records);
   * `FIELD`: `createdTimestamp` and `Index Type`: `SORTABLE` (needed to sort them by creation time).
7. Click *Save Changes*
