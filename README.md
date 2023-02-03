# encrypt_db [![pub package](https://img.shields.io/pub/v/encrypt_db.svg)](https://pub.dartlang.org/packages/encrypt_db)

### Encrypt your database

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
  encrypt_db.write('secret_key', 'secret_value');
  encrypt_db.read(key: 'secret_key', defaultValue: 'default_value');
  print('Hello world: ${encrypt_db.value}!');
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]:

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

- [Debojyoti Singha] (Debojyoti Singha)

