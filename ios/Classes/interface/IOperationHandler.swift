//
//  IOperationHandler.swift
//  encrypt_db
//
//  Created by Debojyoti Singha on 03/02/23.
//

import Foundation

protocol IOperationHandler {
    func read(key: String, group: String, result: @escaping FlutterResult)
    func write()
}
