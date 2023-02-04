import 'package:dart_std/dart_std.dart';
import 'package:encrypt_db/encrypt_db.dart';
import 'package:encrypt_db/src/core/encrypt_db_method_channel.dart';
import 'package:encrypt_db/src/core/encrypt_db_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEncryptDbPlatform
    with MockPlatformInterfaceMixin
    implements EncryptDbPlatform {
  Pair<String, dynamic>? _pairData =
      const Pair<String, dynamic>('', '');

  @override
  void initializeEncryptDb({
    EncryptInformationModel? encryptInformationModel,
  }) {}

  @override
  Future read<T>({
    required String key,
    required T defaultValue,
  }) {
    return Future.value(_pairData?.second);
  }

  @override
  void write<T>({
    required String key,
    required T value,
  }) {
    if (T == String) {
      _pairData = Pair(key, value as String);
    } else if (T == int) {
      _pairData = Pair(key, value as int);
    } else if (T == double) {
      _pairData = Pair(key, value as double);
    } else if (T == bool) {
      _pairData = Pair(key, value as bool);
    }
  }

  @override
  Future<dynamic> clearAll() {
    _pairData = null;
    return Future.value(_pairData);
  }

  @override
  Future<dynamic> clear({required String key}) {
    if (_pairData?.first == key) {
      _pairData = null;
      return Future.value(_pairData);
    }
    return Future.value(_pairData);
  }

  @override
  Future<dynamic> readAll() {
    if (_pairData?.first.isEmpty ?? false) {
      return Future.value(null);
    }
    return Future.value(_pairData);
  }
}

void main() {
  final EncryptDbPlatform initialPlatform =
      EncryptDbPlatform.instance;

  test('$MethodChannelEncryptDb is the default instance',
      () {
    expect(initialPlatform,
        isInstanceOf<MethodChannelEncryptDb>());
  });

  test('positive write test', () async {
    EncryptDb encryptDbPlugin = EncryptDb();
    MockEncryptDbPlatform fakePlatform =
        MockEncryptDbPlatform();
    EncryptDbPlatform.instance = fakePlatform;
    encryptDbPlugin.write(key: 'key', value: 'value1');
    var data = await encryptDbPlugin.read(
        key: 'key', defaultValue: 'value');
    expect(data, 'value1');
  });

  test('negative write test', () async {});
}
