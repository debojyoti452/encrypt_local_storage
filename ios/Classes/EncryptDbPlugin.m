#import "EncryptDbPlugin.h"
#if __has_include(<encrypt_db/encrypt_db-Swift.h>)
#import <encrypt_db/encrypt_db-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "encrypt_db-Swift.h"
#endif

@implementation EncryptDbPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEncryptDbPlugin registerWithRegistrar:registrar];
}
@end
