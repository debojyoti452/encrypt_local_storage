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
import androidx.security.crypto.EncryptedFile
import androidx.security.crypto.MasterKeys
import com.swing.encrypt_db.model.EncryptInformationModel
import java.io.File
import kotlin.coroutines.suspendCoroutine

class EncryptFilePrefManager(
    context: Context,
    val encryptInformationModel: EncryptInformationModel
) {
    private var secretHashKey: String
    private var encryptedFileManager: EncryptedFile

    init {
        // This is to make sure that the encryptedFile is initialized
        // before the first use of it.
        encryptedFileManager = getInstanceOfEncryptedFile(context)

        val keyGenParameterSpec = MasterKeys.AES256_GCM_SPEC
        secretHashKey = MasterKeys.getOrCreate(keyGenParameterSpec)
    }

    private suspend fun writeEncryptedFile(key: String, data: String): String =
        suspendCoroutine {
            try {
                val encryptedFile = encryptedFileManager
                val outputStream = encryptedFile.openFileOutput()
                outputStream.write(data.toByteArray())
                outputStream.close()
                outputStream.flush()
                it.resumeWith(Result.success("success"))
            } catch (e: Exception) {
                e.printStackTrace()
                it.resumeWith(Result.failure(e))
            }
        }

    private suspend fun readEncryptedFile(key: String): String =
        suspendCoroutine {
            try {
                val encryptedFile = encryptedFileManager
                val inputStream = encryptedFile.openFileInput()
                val data = inputStream.readBytes()
                inputStream.close()
                it.resumeWith(Result.success(String(data)))
            } catch (e: Exception) {
                e.printStackTrace()
                it.resumeWith(Result.failure(e))
            }
        }

    private fun getInstanceOfEncryptedFile(context: Context): EncryptedFile {
        return EncryptedFile.Builder(
            File(
                context.filesDir,
                "${encryptInformationModel.version}_${encryptInformationModel.fileName}"
            ),
            context,
            secretHashKey,
            EncryptedFile.FileEncryptionScheme.AES256_GCM_HKDF_4KB
        ).build()
    }
}
