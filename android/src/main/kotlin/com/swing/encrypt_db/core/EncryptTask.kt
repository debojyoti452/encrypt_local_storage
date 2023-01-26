package com.swing.encrypt_db.core

import android.content.Context
import com.swing.encrypt_db.utils.EncryptFileUtils

open class EncryptTask constructor(private val context: Context) {

    suspend fun write(key: String, value: String) {
        EncryptFileUtils.writeEncryptedFile(context, key, value)
    }

    suspend fun read(key: String): String {
        return EncryptFileUtils.readEncryptedFile(context, key)
    }
}
