# Encrypt DB

[![pub package](https://img.shields.io/pub/v/encrypt_db.svg)](https://pub.dartlang.org/packages/encrypt_db)

## Description

A Flutter plugin to encrypt and decrypt data using AES-256 encryption algorithm.

## Features

- Android and iOS support
- AES-256 encryption algorithm
- Keychain support for iOS
- KeyStore support for Android

## Installation

Add this line to your application's pubspec.yaml file:

```yaml
dependencies:
  encrypt_db: ^0.0.3
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

## License

```
Copyright 2023 Debojyoti Singha. All rights reserved.


 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
```

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
