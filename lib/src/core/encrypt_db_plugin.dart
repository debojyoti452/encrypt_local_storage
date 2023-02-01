import '../../encrypt_db.dart';
import 'encrypt_db_platform_interface.dart';

class EncryptDb {
  Future<String?> getPlatformVersion() {
    return EncryptDbPlatform.instance.getPlatformVersion();
  }

  Future<void> initializeEncryptDb({
    EncryptInformationModel? encryptInformationModel,
  }) {
    return EncryptDbPlatform.instance.initializeEncryptDb(
      encryptInformationModel: encryptInformationModel,
    );
  }

  void writeData<T>({
    required String key,
    required T value,
  }) {
    return EncryptDbPlatform.instance
        .writeData(key: key, value: value);
  }

  Future<dynamic> readData<T>({
    required String key,
    required T defaultValue,
  }) {
    return EncryptDbPlatform.instance
        .readData(key: key, defaultValue: defaultValue);
  }
}
