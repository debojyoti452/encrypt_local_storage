/*
 * *
 *  * * MIT License
 *  * *******************************************************************************************
 *  *  * Created By Debojyoti Singha
 *  *  * Copyright (c) 2023.
 *  *  * Permission is hereby granted, free of charge, to any person obtaining a copy
 *  *  * of this software and associated documentation files (the "Software"), to deal
 *  *  * in the Software without restriction, including without limitation the rights
 *  *  * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  *  * copies of the Software, and to permit persons to whom the Software is
 *  *  * furnished to do so, subject to the following conditions:
 *  *  *
 *  *  * The above copyright notice and this permission notice shall be included in all
 *  *  * copies or substantial portions of the Software.
 *  *  *
 *  *  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  *  * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  *  * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  *  * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  *  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  *  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  *  * SOFTWARE.
 *  *  * Contact Email: support@swingtechnologies.in
 *  * ******************************************************************************************
 *
 */

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
