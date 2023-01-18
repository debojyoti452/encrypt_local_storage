import 'package:flutter_test/flutter_test.dart';
import 'package:encrypt_db/encrypt_db.dart';
import 'package:encrypt_db/encrypt_db_platform_interface.dart';
import 'package:encrypt_db/encrypt_db_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEncryptDbPlatform
    with MockPlatformInterfaceMixin
    implements EncryptDbPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final EncryptDbPlatform initialPlatform = EncryptDbPlatform.instance;

  test('$MethodChannelEncryptDb is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEncryptDb>());
  });

  test('getPlatformVersion', () async {
    EncryptDb encryptDbPlugin = EncryptDb();
    MockEncryptDbPlatform fakePlatform = MockEncryptDbPlatform();
    EncryptDbPlatform.instance = fakePlatform;

    expect(await encryptDbPlugin.getPlatformVersion(), '42');
  });
}
