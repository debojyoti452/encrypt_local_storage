
import 'encrypt_db_platform_interface.dart';

class EncryptDb {
  Future<String?> getPlatformVersion() {
    return EncryptDbPlatform.instance.getPlatformVersion();
  }
}
