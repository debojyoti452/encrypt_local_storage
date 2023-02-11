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
