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
          values: map['record'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Cannot parse cloud kit response: $e');
    }
  }
}
