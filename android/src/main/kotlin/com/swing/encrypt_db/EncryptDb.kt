package com.swing.encrypt_db

import android.content.Context
import com.swing.encrypt_db.core.EncryptTask
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class EncryptDb constructor(
    private val context: Context
) {
    private val mainScope = CoroutineScope(Dispatchers.Main)
    private lateinit var encryptTask: EncryptTask
    fun init() {
        mainScope.launch {
            try {
                withContext(Dispatchers.Default) {
                    encryptTask = EncryptTask(context = context)
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }
}
