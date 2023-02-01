import 'package:encrypt_db/src/constants/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../encrypt_db_plugin.dart';
import 'encrypt_db_platform_interface.dart';

class MethodChannelEncryptDb extends EncryptDbPlatform {
  @visibleForTesting
  final methodChannel =
      const MethodChannel(AppConstants.CHANNEL_NAME);

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>(
      AppConstants.METHOD_GET_PLATFORM_VERSION,
    );
    return version;
  }

  @override
  Future<void> initializeEncryptDb({
    EncryptInformationModel? encryptInformationModel,
  }) {
    final result = methodChannel.invokeMethod<void>(
      AppConstants.METHOD_INITIATE,
      {
        AppConstants.METHOD_INITIATE:
            encryptInformationModel?.toMap(),
      },
    );
    return result;
  }

  @override
  void writeData<T>({
    required String key,
    required T value,
  }) async {
    await methodChannel.invokeMapMethod(
      AppConstants.METHOD_WRITE_DATA,
      {
        AppConstants.METHOD_WRITE_DATA: {
          'key': key,
          'value': value,
        }
      },
    );
  }

  @override
  Future<dynamic> readData<T>({
    required String key,
    required T defaultValue,
  }) async {
    final value = await methodChannel.invokeMethod(
      AppConstants.METHOD_READ_DATA,
      {
        AppConstants.METHOD_READ_DATA: {
          'key': key,
          'defaultValue': defaultValue,
        }
      },
    );
    return value;
  }
}
