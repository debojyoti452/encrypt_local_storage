package com.swing.encrypt_db.utils

object EncryptUtils {
    // instance type variable
    fun Any.fileType(): String {
        return when (this) {
            is String -> "String"
            is Int -> "Int"
            is Long -> "Long"
            is Float -> "Float"
            is Double -> "Double"
            is Boolean -> "Boolean"
            else -> "Unknown"
        }
    }

    // shared pref read


}


