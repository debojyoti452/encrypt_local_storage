package com.swing.encrypt_db.core

sealed class EncryptTask<T> {
    suspend fun write() {

    }

    suspend fun read() : T {
        return Class.forName("T") as T
    }

    suspend fun delete() : Boolean {
        return true
    }

    suspend fun contains(key: String) : Boolean {
        return false
    }

    suspend fun clear() : Boolean {
        return true
    }
}
