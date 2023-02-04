import '../../encrypt_db.dart';
import 'encrypt_db_platform_interface.dart';

class EncryptDb {
  void initializeEncryptDb({
    EncryptInformationModel? encryptInformationModel,
  }) async {
    EncryptDbPlatform.instance.initializeEncryptDb(
      encryptInformationModel: encryptInformationModel,
    );
  }

  void write<T>({
    required String key,
    required T value,
  }) {
    return EncryptDbPlatform.instance
        .write(key: key, value: value);
  }

  Future<dynamic> read<T>({
    required String key,
    required T defaultValue,
  }) {
    return EncryptDbPlatform.instance
        .read(key: key, defaultValue: defaultValue);
  }

  Future<dynamic> readAll() {
    return EncryptDbPlatform.instance.readAll();
  }

  Future<dynamic> clear({
    required String key,
  }) {
    return EncryptDbPlatform.instance.clear(key: key);
  }

  Future<dynamic> clearAll() {
    return EncryptDbPlatform.instance.clearAll();
  }
}
