enum CloudKitAccountStatus {
  /// CloudKit can’t determine the status of the user’s iCloud account.
  couldNotDetermine(0),

  /// The user’s iCloud account is available.
  available(1),

  /// The system denies access to the user’s iCloud account.
  restricted(2),

  /// The device doesn’t have an iCloud account.
  noAccount(3),

  /// The user’s iCloud account is temporarily unavailable.
  temporarilyUnavailable(4),

  /// Unknown status
  unknown(99);

  const CloudKitAccountStatus(this.value);

  final num value;
}
