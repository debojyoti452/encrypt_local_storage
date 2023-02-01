package com.swing.encrypt_db.model

import com.swing.encrypt_db.constants.EncryptDbMode
import com.swing.encrypt_db.constants.EncryptionType
import com.swing.encrypt_db.constants.SecureHashes
import com.swing.encrypt_db.utils.Extensions.toValue

data class EncryptInformationModel(
    var fileName: String,
    var version: Int,
    var encryptionType: EncryptionType,
    var encryptDbMode: EncryptDbMode,
) {
    private fun toMap(): Map<String, Any?> {
        return mapOf(
            "fileName" to fileName,
            "version" to version,
            "encryptionType" to encryptionType.toValue(),
            "encryptMethodType" to encryptDbMode.toValue(),
        )
    }

    // function to string
    override fun toString(): String {
        return toMap().toString()
    }

    // function default instance
    companion object {
        fun defaultInstance(): EncryptInformationModel {
            return EncryptInformationModel(
                fileName = SecureHashes.STORAGE_SHARED_PREF_NAME,
                version = SecureHashes.STORAGE_SHARED_PREF_VERSION,
                encryptionType = EncryptionType.AES,
                encryptDbMode = EncryptDbMode.SHARED_PREF,
            )
        }
    }
}
