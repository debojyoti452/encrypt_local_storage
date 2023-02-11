/*
 * *
 *  * * MIT License
 *  * *******************************************************************************************
 *  *  * Created By Debojyoti Singha
 *  *  * Copyright (c) 2023.
 *  *  * Permission is hereby granted, free of charge, to any person obtaining a copy
 *  *  * of this software and associated documentation files (the "Software"), to deal
 *  *  * in the Software without restriction, including without limitation the rights
 *  *  * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  *  * copies of the Software, and to permit persons to whom the Software is
 *  *  * furnished to do so, subject to the following conditions:
 *  *  *
 *  *  * The above copyright notice and this permission notice shall be included in all
 *  *  * copies or substantial portions of the Software.
 *  *  *
 *  *  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  *  * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  *  * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  *  * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  *  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  *  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  *  * SOFTWARE.
 *  *  * Contact Email: support@swingtechnologies.in
 *  * ******************************************************************************************
 *
 */

package com.swing.encrypt_db

import com.swing.encrypt_db.constants.AppConstants
import com.swing.encrypt_db.constants.AppConstants.METHOD_CLEAR_ALL
import com.swing.encrypt_db.constants.AppConstants.METHOD_DELETE
import com.swing.encrypt_db.constants.AppConstants.METHOD_INITIATE
import com.swing.encrypt_db.constants.AppConstants.METHOD_READ_ALL
import com.swing.encrypt_db.constants.AppConstants.METHOD_READ_DATA
import com.swing.encrypt_db.constants.AppConstants.METHOD_WRITE_DATA
import com.swing.encrypt_db.constants.EncryptDbErrorCodes
import com.swing.encrypt_db.constants.EncryptDbMode
import com.swing.encrypt_db.constants.EncryptionType
import com.swing.encrypt_db.core.EncryptDb
import com.swing.encrypt_db.model.EncryptInformationModel
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MethodHandlerImpl constructor(
    messenger: BinaryMessenger,
    flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
) : MethodChannel.MethodCallHandler {
    private var encryptDb: EncryptDb
    private var methodChannel: MethodChannel? = null

    init {
        methodChannel = MethodChannel(messenger, AppConstants.CHANNEL_NAME)
        methodChannel?.setMethodCallHandler(this)
        encryptDb = EncryptDb(flutterPluginBinding.applicationContext)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            METHOD_INITIATE -> {
                val receivedData = call.argument<Map<String, Any>>(METHOD_INITIATE)
                var encryptInformationModel = EncryptInformationModel.defaultInstance()
                if (receivedData != null) {
                    encryptInformationModel = encryptInformationModel.copy(
                        version = receivedData["version"] as Int,
                        fileName = receivedData["fileName"] as String,
                        encryptionType = EncryptionType.valueOf(
                            receivedData["encryptionType"] as String
                        ),
                        encryptDbMode = EncryptDbMode.valueOf(
                            receivedData["encryptMethodType"] as String
                        )
                    )
                }
                encryptDb.init(encryptInformationModel)
                result.success(true)
            }
            METHOD_WRITE_DATA -> {
                val receivedData = call.argument<Map<String, Any>>(METHOD_WRITE_DATA)

                if (receivedData == null) {
                    result.error(
                        EncryptDbErrorCodes.invalidArgumentError.first,
                        EncryptDbErrorCodes.invalidArgumentError.second,
                        null
                    )
                    return
                }

                if (!encryptDb.isInitialized()) {
                    encryptDb.init(EncryptInformationModel.defaultInstance())
                }
                encryptDb.write(
                    Pair(
                        receivedData["key"] as String,
                        receivedData["value"] as Any
                    )
                )
            }
            METHOD_READ_DATA -> {
                val receivedData = call.argument<Map<String, Any>>(METHOD_READ_DATA)
                if (receivedData == null) {
                    result.error(
                        EncryptDbErrorCodes.invalidArgumentError.first,
                        EncryptDbErrorCodes.invalidArgumentError.second,
                        null
                    )
                    return
                }

                if (!encryptDb.isInitialized()) {
                    encryptDb.init(EncryptInformationModel.defaultInstance())
                }

                val pairData = Pair(
                    receivedData["key"] as String,
                    receivedData["defaultValue"] as Any
                )

                when (pairData.second) {
                    is String -> {
                        encryptDb.readString(pairData, result)
                    }
                    is Int -> {
                        encryptDb.readInt(pairData, result)
                    }
                    is Double -> {
                        encryptDb.readDouble(pairData, result)
                    }
                    is Boolean -> {
                        encryptDb.readBoolean(pairData, result)
                    }
                    is Long -> {
                        encryptDb.readLong(pairData, result)
                    }
                    else -> {
                        result.error(
                            EncryptDbErrorCodes.invalidArgumentError.first,
                            EncryptDbErrorCodes.invalidArgumentError.second,
                            null
                        )
                    }
                }
            }
            METHOD_READ_ALL -> {
                encryptDb.readAll(result)
            }
            METHOD_CLEAR_ALL -> {
                encryptDb.clearAll(result)
            }
            METHOD_DELETE -> {
                val receivedData = call.argument<Map<String, Any>>(METHOD_DELETE)
                if (receivedData == null) {
                    result.error(
                        EncryptDbErrorCodes.invalidArgumentError.first,
                        EncryptDbErrorCodes.invalidArgumentError.second,
                        null
                    )
                    return
                }
                encryptDb.delete(receivedData["key"] as String, result)
            }
            else -> result.notImplemented()
        }
    }

    fun dispose() {
        methodChannel?.setMethodCallHandler(null)
    }
}
