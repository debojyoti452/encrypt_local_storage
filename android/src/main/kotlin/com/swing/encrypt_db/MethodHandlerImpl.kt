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
