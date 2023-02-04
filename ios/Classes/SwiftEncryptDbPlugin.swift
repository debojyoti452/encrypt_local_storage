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
            encryptDb.initialize()
            result(true)

        case Constants.METHOD_READ_DATA:
            let arguments = call.arguments as! [String: Any?]
            let data = arguments[Constants.METHOD_READ_DATA] as! [String: Any]
            let key = data["key"] as! String
            let defaultValue = data["defaultValue"]
            switch (defaultValue) {
            case is String:
                encryptDb.getString(key: key, result: result)
            case is Int:
                encryptDb.getInt(key: key, result: result)
            case is Bool:
                encryptDb.getBool(key: key, result: result)
            case is Double:
                encryptDb.getDouble(key: key, result: result)
            default:
                result(FlutterMethodNotImplemented)
            }

        case Constants.METHOD_WRITE_DATA:
            let arguments = call.arguments as! [String: Any?]
            let data = arguments[Constants.METHOD_WRITE_DATA] as! [String: Any]

            let key = data["key"] as! String
            let value = data["value"] as! String
            encryptDb.write(key: key, value: value, result: result)

        case Constants.METHOD_READ_ALL:
            encryptDb.readAll(result: result)

        case Constants.METHOD_CLEAR_ALL:
            encryptDb.clearAll(result: result)

        case Constants.METHOD_DELETE:
            let arguments = call.arguments as! [String: Any?]
            let data = arguments[Constants.METHOD_DELETE] as! [String: Any]
            let key = data["key"] as! String
            encryptDb.clear(key: key, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
