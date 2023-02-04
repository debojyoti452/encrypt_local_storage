import 'package:encrypt_db/encrypt_db.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'encrypt_db_method_channel.dart';

abstract class EncryptDbPlatform extends PlatformInterface {
  /// Constructs a EncryptDbPlatform.
  EncryptDbPlatform() : super(token: _token);

  static final Object _token = Object();

  static EncryptDbPlatform _instance =
      MethodChannelEncryptDb();

  static EncryptDbPlatform get instance => _instance;

  static set instance(EncryptDbPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void initializeEncryptDb({
    EncryptInformationModel? encryptInformationModel,
  }) async {
    throw UnimplementedError(
        'initializeEncryptDb() has not been implemented.');
  }

  void write<T>({
    required String key,
    required T value,
  }) {
    throw UnimplementedError(
        'writeData() has not been implemented.');
  }

  Future<dynamic> read<T>({
    required String key,
    required T defaultValue,
  }) {
    throw UnimplementedError(
        'readData() has not been implemented.');
  }

  Future<dynamic> readAll() {
    throw UnimplementedError(
        'readAll() has not been implemented.');
  }

  Future<dynamic> clear({
    required String key,
  }) {
    throw UnimplementedError(
        'delete() has not been implemented.');
  }

  Future<dynamic> clearAll() {
    throw UnimplementedError(
        'clearAll() has not been implemented.');
  }
}
