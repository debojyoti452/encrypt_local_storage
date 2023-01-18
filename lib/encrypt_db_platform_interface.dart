import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'encrypt_db_method_channel.dart';

abstract class EncryptDbPlatform extends PlatformInterface {
  /// Constructs a EncryptDbPlatform.
  EncryptDbPlatform() : super(token: _token);

  static final Object _token = Object();

  static EncryptDbPlatform _instance = MethodChannelEncryptDb();

  /// The default instance of [EncryptDbPlatform] to use.
  ///
  /// Defaults to [MethodChannelEncryptDb].
  static EncryptDbPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EncryptDbPlatform] when
  /// they register themselves.
  static set instance(EncryptDbPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
