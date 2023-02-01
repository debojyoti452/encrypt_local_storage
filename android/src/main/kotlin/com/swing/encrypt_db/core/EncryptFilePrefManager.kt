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

    private suspend fun writeEncryptedFile(key: String, data: String) =
        suspendCoroutine {
            try {
                val encryptedFile = encryptedFileManager
                val outputStream = encryptedFile.openFileOutput()
                outputStream.write(data.toByteArray())
                outputStream.close()
                outputStream.flush()
                it.resumeWith(Result.success(Unit))
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
