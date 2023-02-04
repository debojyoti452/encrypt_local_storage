//
//  IOperationHandler.swift
//  encrypt_db
//
//  Created by Debojyoti Singha on 03/02/23.
//
import Flutter

protocol IOperationHandler {
    func initialize()

    func getString(key: String, result: @escaping FlutterResult)

    func getInt(key: String, result: @escaping FlutterResult)

    func getBool(key: String, result: @escaping FlutterResult)

    func getDouble(key: String, result: @escaping FlutterResult)

    func write(key: String, value: String, result: @escaping FlutterResult)

    func readAll(result: @escaping FlutterResult)

    func clear(key: String, result: @escaping FlutterResult)

    func clearAll(result: @escaping FlutterResult)
}
