import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'encrypt_db_platform_interface.dart';

/// An implementation of [EncryptDbPlatform] that uses method channels.
class MethodChannelEncryptDb extends EncryptDbPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('encrypt_db');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
