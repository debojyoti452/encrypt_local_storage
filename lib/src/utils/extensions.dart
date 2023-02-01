/// enum to string
extension EnumToString on Enum {
  String get toName => toString().split('.').last;
}
