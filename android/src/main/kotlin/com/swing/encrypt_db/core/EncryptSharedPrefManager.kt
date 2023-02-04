package com.swing.encrypt_db.core

import android.content.Context
import android.content.SharedPreferences
import android.util.Log
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKeys
import com.swing.encrypt_db.constants.AppConstants
import com.swing.encrypt_db.model.EncryptInformationModel
import kotlin.coroutines.suspendCoroutine

class EncryptSharedPrefManager constructor(
    context: Context,
    val encryptInformationModel: EncryptInformationModel,
) {

    private var secretHashKey: String

    private var encryptedSharedPreferences: SharedPreferences

    init {
        // This is to make sure that the encryptedSharedPreferences is initialized
        // before the first use of it.
        encryptedSharedPreferences = getInstanceEncryptedSharedPreferences(context)

        val keyGenParameterSpec = MasterKeys.AES256_GCM_SPEC
        secretHashKey = MasterKeys.getOrCreate(keyGenParameterSpec)

        Log.d(AppConstants.TAG, "mainKeyAlias: $secretHashKey")
    }

    suspend fun writeSharedPref(key: String, value: Any) = suspendCoroutine<Unit> {
        val editor = encryptedSharedPreferences.edit()
        when (value) {
            is String -> editor.putString(key, value)
            is Int -> editor.putInt(key, value)
            is Long -> editor.putLong(key, value)
            is Float -> editor.putFloat(key, value)
            is Double -> editor.putFloat(key, value.toFloat())
            is Boolean -> editor.putBoolean(key, value)
            else -> editor.putString(key, value.toString())
        }
        editor.apply()
    }

    suspend fun readSharedPref(key: String, defaultValue: Any): Any = suspendCoroutine {
        when (defaultValue) {
            is String -> it.resumeWith(
                Result.success(
                    encryptedSharedPreferences.getString(
                        key,
                        defaultValue
                    ) as String
                )
            )
            is Int -> it.resumeWith(
                Result.success(
                    encryptedSharedPreferences.getInt(
                        key,
                        defaultValue
                    )
                )
            )
            is Long -> it.resumeWith(
                Result.success(
                    encryptedSharedPreferences.getLong(
                        key,
                        defaultValue
                    )
                )
            )
            is Double -> it.resumeWith(
                Result.success(
                    encryptedSharedPreferences.getFloat(
                        key,
                        defaultValue.toFloat()
                    ).toDouble()
                )
            )
            is Boolean -> it.resumeWith(
                Result.success(
                    encryptedSharedPreferences.getBoolean(
                        key,
                        defaultValue
                    )
                )
            )
            else -> it.resumeWith(
                Result.success(
                    encryptedSharedPreferences.getString(
                        key,
                        null
                    ) as String
                )
            )
        }
    }

    suspend fun readAllSharedPref(): Map<String, *> = suspendCoroutine {
        it.resumeWith(Result.success(encryptedSharedPreferences.all))
    }

    suspend fun clearAllSharedPref(): Boolean = suspendCoroutine {
        encryptedSharedPreferences.edit().clear().apply()
        it.resumeWith(Result.success(true))
    }

    suspend fun deleteSharedPref(key: String): Boolean = suspendCoroutine {
        encryptedSharedPreferences.edit().remove(key).apply()
        it.resumeWith(Result.success(true))
    }

    private fun getInstanceEncryptedSharedPreferences(context: Context): SharedPreferences {
        return EncryptedSharedPreferences.create(
            "${encryptInformationModel.version}_${encryptInformationModel.fileName}",
            secretHashKey,
            context,
            EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
            EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
        )
    }
}
