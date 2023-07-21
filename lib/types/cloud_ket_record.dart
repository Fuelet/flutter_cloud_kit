Map<String, dynamic> _parseRecord(Object? record) {
  return (record as Map<Object?, Object?>)
      .map((key, value) => MapEntry(key.toString(), value));
}

class CloudKitRecord {
  final String recordType;
  final String recordName;
  final Map<String, dynamic> values;

  CloudKitRecord(
      {required this.recordType,
      required this.recordName,
      required this.values});

  factory CloudKitRecord.fromMap(Map<Object?, Object?> map) {
    try {
      return CloudKitRecord(
          recordType: map['recordType'] as String,
          recordName: map['recordName'] as String,
          values: _parseRecord(map['record']));
    } catch (e) {
      throw Exception('Cannot parse cloud kit response: $e');
    }
  }
}
