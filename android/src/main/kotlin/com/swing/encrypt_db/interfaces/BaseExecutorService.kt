package com.swing.encrypt_db.interfaces

interface BaseExecutorService<INPUT, OUTPUT> {
    suspend fun execute(input: INPUT, onResult: (OUTPUT) -> Unit)
}
