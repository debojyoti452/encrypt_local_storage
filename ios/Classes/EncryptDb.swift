//
//  EncryptDb.swift
//  encrypt_db
//
//  Created by Debojyoti Singha on 03/02/23.
//
import Flutter

class EncryptDb : IOperationHandler {
    private var keychainSwift: KeychainSwift!

    func initialize() {
        keychainSwift = KeychainSwift()
    }

    func getString(key: String, result: @escaping FlutterResult) {
        let data = keychainSwift.get(key)
        result(data)
    }

    func getInt(key: String, result: @escaping FlutterResult) {
        let data = keychainSwift.get(key)
        result(data)
    }

    func getBool(key: String, result: @escaping FlutterResult) {
        let data = keychainSwift.getBool(key)
        result(data)
    }

    func getDouble(key: String, result: @escaping FlutterResult) {
        let data = keychainSwift.get(key)
        result(data)
    }

    func write(key: String, value: String, result: @escaping FlutterResult) {
        debugPrint("value: \(value) key: \(key)")
        let data = keychainSwift.set(value, forKey: key)
        if (data) {
            debugPrint("success")
        } else {
            debugPrint("failed")
        }
    }

    func readAll(result: @escaping FlutterResult) {
        let data = keychainSwift.allKeys
        result(data)
    }

    func clearAll(result: @escaping FlutterResult) {
        let data = keychainSwift.clear()
        if (data) {
            debugPrint("success")
        } else {
            debugPrint("failed")
        }
    }

    func clear(key: String, result: @escaping FlutterResult) {
        let data = keychainSwift.delete(key)
        if (data) {
            debugPrint("success")
        } else {
            debugPrint("failed")
        }
    }
}
