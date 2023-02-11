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

    override fun readAll(result: MethodChannel.Result) {
        coroutineScope.launch {
            try {
                val fetchedData = withContext(Dispatchers.Default) {
                    encryptSharedPrefManager.readAllSharedPref()
                }
                result.success(fetchedData)
            } catch (e: Exception) {
                e.printStackTrace()
                result.error("ERROR", e.message, null)
            }
        }
    }

    override fun delete(key: String, result: MethodChannel.Result) {
        coroutineScope.launch {
            try {
                val fetchedData = withContext(Dispatchers.Default) {
                    encryptSharedPrefManager.deleteSharedPref(key)
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

    override fun clearAll(result: MethodChannel.Result) {
        coroutineScope.launch {
            try {
                val fetchedData = withContext(Dispatchers.Default) {
                    encryptSharedPrefManager.clearAllSharedPref()
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
