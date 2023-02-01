package com.swing.encrypt_db.interfaces

import io.flutter.plugin.common.MethodChannel

interface IOperationHandler {
    fun write(pairData: Pair<String, Any>)
    fun readString(pairData: Pair<String, Any>, result: MethodChannel.Result)
    fun readInt(pairData: Pair<String, Any>, result: MethodChannel.Result)
    fun readDouble(pairData: Pair<String, Any>, result: MethodChannel.Result)
    fun readBoolean(pairData: Pair<String, Any>, result: MethodChannel.Result)
    fun readLong(pairData: Pair<String, Any>, result: MethodChannel.Result)
}
