import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:encrypt_db/encrypt_db_method_channel.dart';

void main() {
  MethodChannelEncryptDb platform = MethodChannelEncryptDb();
  const MethodChannel channel = MethodChannel('encrypt_db');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
