import 'package:encrypt_db/src/constants/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../encrypt_db.dart';
import 'encrypt_db_platform_interface.dart';

class MethodChannelEncryptDb extends EncryptDbPlatform {
  @visibleForTesting
  final methodChannel =
      const MethodChannel(AppConstants.CHANNEL_NAME);

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
  void write<T>({
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
  Future<dynamic> read<T>({
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

  @override
  Future<dynamic> readAll() {
    final result = methodChannel.invokeMethod(
      AppConstants.METHOD_READ_ALL,
    );
    return result;
  }

  @override
  Future<dynamic> clear({required String key}) {
    final result = methodChannel.invokeMethod(
      AppConstants.METHOD_DELETE,
      {
        AppConstants.METHOD_DELETE: {
          'key': key,
        }
      },
    );
    return result;
  }

  @override
  Future<dynamic> clearAll() {
    final result = methodChannel.invokeMethod(
      AppConstants.METHOD_CLEAR_ALL,
    );
    return result;
  }
}
