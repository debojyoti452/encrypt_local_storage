import Flutter
import UIKit

public class SwiftEncryptDbPlugin: NSObject, FlutterPlugin {

    private let encryptDb: EncryptDb = EncryptDb()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: Constants.CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let instance = SwiftEncryptDbPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case Constants.METHOD_GET_PLATFORM_VERSION:
            result("iOS " + UIDevice.current.systemVersion)
        case Constants.METHOD_INITIATE:
            result("iOS " + UIDevice.current.systemVersion)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
