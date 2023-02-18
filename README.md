# Encrypt DB

[![pub package](https://img.shields.io/pub/v/encrypt_db.svg)](https://pub.dartlang.org/packages/encrypt_db)
[![Build Project](https://github.com/debojyoti452/encrypt_local_storage/actions/workflows/build.yml/badge.svg)](https://github.com/debojyoti452/encrypt_local_storage/actions/workflows/build.yml)

## Description

A Flutter plugin to encrypt and decrypt data using AES-256 encryption algorithm. 
You can use this plugin to store sensitive data in the local storage. 
eg. User credentials, API keys, Bearer Token etc.

## Why this plugin?

- This plugin uses AES-256 encryption algorithm to encrypt and decrypt data.
- This plugin uses Keychain for iOS and KeyStore for Android to store the encryption key.
- This plugin can store `String`, `int`, `double`, and `bool` data types.


## Installation

Add this line to your application's pubspec.yaml file:

```yaml
dependencies:
  encrypt_db: latest_version
```

## Getting Started
### Read and Write

```dart
_encrytDbPlugin.write(key: 'key1', value: 'value1'); /// Return nothing, but write a value
_encrytDbPlugin.read(key: 'key1', defaultValue: ''); /// Return a value of type defaultValue type
_encrytDbPlugin.readAll(); /// Return a Map<String, dynamic> 
```

### ClearAll and Clear Specific Key

```dart
_encrytDbPlugin.clearAll(); /// Return nothing, but clear all the data
_encrytDbPlugin.clear(key: 'key1'); /// Return nothing, but clear a specific key
```

## Example

```dart
import 'package:encrypt_db/encrypt_db.dart';

main() async {
  var _encryptDbPlugin = new EncryptDb();
  
  var result = await _encryptDbPlugin.readAll();
  debugPrint('result0: $result');
  
  await _encryptDbPlugin.clearAll();
  debugPrint('Clear all');
  
  result = await _encryptDbPlugin.readAll();
  debugPrint('result1: $result');
  
  _encryptDbPlugin.write(key: 'key1', value: 'value1');
  debugPrint('Write key1');
  
  result = await _encryptDbPlugin.read(
      key: 'key1', defaultValue: 'default_value');
  debugPrint('result2: $result');
  
  _encryptDbPlugin.write(key: 'key2', value: 'value2');
  debugPrint('Write key2');
  
  result = await _encryptDbPlugin.readAll();
  debugPrint('result3: $result');
  
  _encryptDbPlugin.clear(key: 'key1');
  debugPrint('Delete key1');
  
  result = await _encryptDbPlugin.readAll();
  debugPrint('result4: $result');
  
  _encryptDbPlugin.clearAll();
  debugPrint('Clear all');
}
```
## Important Note

- This plugin requires async/await support. So, you need to use `Flutter 1.12.13+hotfix.5` or higher.
- Android API level 28 or higher is required.
- iOS 10.0 or higher is required.
- Dart 3 Ready

## Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/debojyoti452/encrypt_local_storage/issues).

## Author

Debojyoti Singha

## Contributors

- [Debojyoti Singha](https://debojyotisingha.com)

## Coming Soon

- [ ] Pluggable Database support
- [ ] Encryption using RSA-2048 algorithm
- [ ] MacOS support
- [ ] Windows support
- [ ] Linux support

## License

```
MIT License

Copyright (c) 2023 Debojyoti Singha

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

