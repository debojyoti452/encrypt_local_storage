enum EncryptType { AES, RSA, DES }

enum EncryptDbMode { SHARED_PREF, FILE_PREF }

class EncryptInformationModel {
  final String? fileName;
  final int? version;
  final EncryptType? encryptType;
  final EncryptDbMode? encryptDbMode;

  EncryptInformationModel({
    this.fileName,
    this.version,
    this.encryptType,
    this.encryptDbMode,
  });

  Map<String, dynamic> toMap() {
    return {
      'fileName': fileName,
      'version': version,
      'encryptType': encryptType?.name,
      'encryptDbMode': encryptDbMode?.name,
    };
  }

  factory EncryptInformationModel.fromMap(
      Map<String, dynamic> map) {
    return EncryptInformationModel(
      fileName: map['fileName'],
      version: map['version'],
      encryptType: EncryptType.values.firstWhere(
          (element) => element.name == map['encryptType']),
      encryptDbMode: EncryptDbMode.values.firstWhere(
          (element) =>
              element.name == map['encryptDbMode']),
    );
  }
}
