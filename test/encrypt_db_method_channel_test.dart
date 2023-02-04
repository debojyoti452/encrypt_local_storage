import 'package:dart_std/dart_std.dart';
import 'package:encrypt_db/src/constants/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'encrypt_db_test.dart';

void main() {
  MockEncryptDbPlatform platform = MockEncryptDbPlatform();
  const MethodChannel channel =
      MethodChannel(AppConstants.CHANNEL_NAME);

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler(
        (MethodCall methodCall) async {
      switch (methodCall.method) {
        case AppConstants.METHOD_READ_ALL:
          return platform.readAll();
        case AppConstants.METHOD_READ_DATA:
          return platform.read(
              key: methodCall.arguments['key'],
              defaultValue:
                  methodCall.arguments['defaultValue']);
        case AppConstants.METHOD_WRITE_DATA:
          return platform.write(
              key: methodCall.arguments['key'],
              value: methodCall.arguments['value']);
        case AppConstants.METHOD_DELETE:
          return platform.clear(
              key: methodCall.arguments['key']);
        case AppConstants.METHOD_CLEAR_ALL:
          return platform.clearAll();
        default:
          return;
      }
    });
  });

  test('positive read all data', () async {
    platform.write(key: 'key1', value: 'value1');
    expect(await platform.readAll(),
        const Pair<String, dynamic>('key1', 'value1'));
  });

  test('negative read all data', () async {
    platform.clearAll();
    expect(await platform.readAll(), null);
  });

  test('write data tests', () async {
    platform.write(key: 'key1', value: 'value1');
    expect(
        await platform.read(key: 'key1', defaultValue: ''),
        'value1');
  });

  test('clear specific key', () async {
    platform.write(key: 'key2', value: 'value2');
    expect(
        await platform.read(
            key: 'key2', defaultValue: 'default'),
        'value2');
    await platform.clear(key: 'key2');
    expect(
        await platform.read(
            key: 'key2', defaultValue: null),
        null);
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
