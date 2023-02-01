package com.swing.encrypt_db.core

import android.content.Context
import com.swing.encrypt_db.constants.EncryptDbMode
import com.swing.encrypt_db.interfaces.IOperationHandler
import com.swing.encrypt_db.model.EncryptInformationModel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class EncryptDb constructor(
    private val context: Context
) : IOperationHandler {
    private val coroutineScope = CoroutineScope(Dispatchers.Main)
    private lateinit var encryptSharedPrefManager: EncryptSharedPrefManager
    private lateinit var encryptFilePrefManager: EncryptFilePrefManager
    fun init(encryptInformationModel: EncryptInformationModel) {
        try {
            when (encryptInformationModel.encryptDbMode) {
                EncryptDbMode.SHARED_PREF -> {
                    encryptSharedPrefManager = EncryptSharedPrefManager(
                        context = context,
                        encryptInformationModel = encryptInformationModel,
                    )
                }
                EncryptDbMode.FILE_PREF -> {
                    encryptFilePrefManager = EncryptFilePrefManager(
                        context = context,
                        encryptInformationModel = encryptInformationModel,
                    )
                }
                else -> {
                    throw Exception("Invalid encrypt method type")
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    override fun write(pairData: Pair<String, Any>) {
        coroutineScope.launch {
            try {
                withContext(Dispatchers.IO) {
                    encryptSharedPrefManager.writeSharedPref(pairData.first, pairData.second)
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

    override fun readString(pairData: Pair<String, Any>, result: MethodChannel.Result) {
        coroutineScope.launch {
            try {
                val fetchedData = withContext(Dispatchers.Default) {
                    encryptSharedPrefManager.readSharedPref(pairData.first, pairData.second)
                }
                val data = if (Result.success(fetchedData).isSuccess) {
                    fetchedData
                } else {
                    "Value is not found"
                }
                result.success(data)
            } catch (e: Exception) {
                e.printStackTrace()
                result.error("ERROR", e.message, null)
            }
        }
    }

    override fun readInt(pairData: Pair<String, Any>, result: MethodChannel.Result) {
        coroutineScope.launch {
            try {
                val fetchedData = withContext(Dispatchers.Default) {
                    encryptSharedPrefManager.readSharedPref(pairData.first, pairData.second)
                }
                val data = if (Result.success(fetchedData).isSuccess) {
                    fetchedData
                } else {
                    "NOT_FOUND"
                }
                result.success(data)
            } catch (e: Exception) {
                e.printStackTrace()
                result.error("ERROR", e.message, null)
            }
        }
    }

    override fun readDouble(pairData: Pair<String, Any>, result: MethodChannel.Result) {
        coroutineScope.launch {
            try {
                val fetchedData = withContext(Dispatchers.Default) {
                    encryptSharedPrefManager.readSharedPref(pairData.first, pairData.second)
                }
                val data = if (Result.success(fetchedData).isSuccess) {
                    fetchedData
                } else {
                    "NOT_FOUND"
                }
                result.success(data)
            } catch (e: Exception) {
                e.printStackTrace()
                result.error("ERROR", e.message, null)
            }
        }
    }

    override fun readBoolean(pairData: Pair<String, Any>, result: MethodChannel.Result) {
        coroutineScope.launch {
            try {
                val fetchedData = withContext(Dispatchers.Default) {
                    encryptSharedPrefManager.readSharedPref(pairData.first, pairData.second)
                }
                val data = if (Result.success(fetchedData).isSuccess) {
                    fetchedData
                } else {
                    "NOT_FOUND"
                }
                result.success(data)
            } catch (e: Exception) {
                e.printStackTrace()
                result.error("ERROR", e.message, null)
            }
        }
    }

    override fun readLong(pairData: Pair<String, Any>, result: MethodChannel.Result) {
        coroutineScope.launch {
            try {
                val fetchedData = withContext(Dispatchers.Default) {
                    encryptSharedPrefManager.readSharedPref(pairData.first, pairData.second)
                }
                val data = if (Result.success(fetchedData).isSuccess) {
                    fetchedData
                } else {
                    "NOT_FOUND"
                }
                result.success(data)
            } catch (e: Exception) {
                e.printStackTrace()
                result.error("ERROR", e.message, null)
            }
        }
    }

    // check whether encrypt instance is initialized or not
    fun isInitialized(): Boolean {
        return ::encryptSharedPrefManager.isInitialized
    }
}
