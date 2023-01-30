package com.swing.encrypt_db.interfaces

import kotlin.coroutines.CoroutineContext

interface CoroutinesContextProvider {
    fun main(): CoroutineContext
    fun io(): CoroutineContext
}
