package com.swing.encrypt_db.utils

import android.content.Context
import androidx.security.crypto.EncryptedFile
import com.swing.encrypt_db.constants.SecureHashes
import java.io.File

object EncryptFileUtils {
    fun writeEncryptedFile(context: Context, fileName: String, data: String) = try {
        val encryptedFile = getInstanceOfEncryptedFile(context, fileName)
        val outputStream = encryptedFile.openFileOutput()
        outputStream.write(data.toByteArray())
        outputStream.close()
    } catch (e: Exception) {
        e.printStackTrace()
    }

    fun readEncryptedFile(context: Context, fileName: String): String {
        try {
            val encryptedFile = getInstanceOfEncryptedFile(context, fileName)
            val inputStream = encryptedFile.openFileInput()
            val data = inputStream.readBytes()
            inputStream.close()
            return String(data)
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return "NOT_FOUND"
    }

    private fun getInstanceOfEncryptedFile(context: Context, fileName: String): EncryptedFile {
        return EncryptedFile.Builder(
            File(context.filesDir, fileName),
            context,
            SecureHashes.STORAGE_FILE_NAME,
            EncryptedFile.FileEncryptionScheme.AES256_GCM_HKDF_4KB
        ).build()
    }
}
