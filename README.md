# Encrypt DB

[![pub package](https://img.shields.io/pub/v/encrypt_db.svg)](https://pub.dartlang.org/packages/encrypt_db)

## Description

A Flutter plugin to encrypt and decrypt data using AES-256 encryption algorithm.

## Features

- `String`, `int`, `double`, and `bool` data types support
- Android and iOS support
- AES-256 encryption algorithm
- Keychain support for iOS
- KeyStore support for Android

## Installation

Add this line to your application's pubspec.yaml file:

```yaml
dependencies:
  encrypt_db: ^0.0.4
```

## Usage

```dart
import 'package:encrypt_db/encrypt_db.dart';

main() {
  var encrypt_db = new EncryptDb();
  encrypt_db.writeData(key: 'secret_key', value: 'secret_value');
  encrypt_db.readData(key: 'secret_key', defaultValue: 'default_value');
  print('Hello world: ${encrypt_db.value}!');
}
```

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

