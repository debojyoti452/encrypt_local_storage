package com.swing.encrypt_db.interfaces

import kotlinx.coroutines.withContext

abstract class BaseBackgroundExecutor<INPUT, OUTPUT>(
    private val coroutineScope: CoroutinesContextProvider
) : BaseExecutorService<INPUT, OUTPUT> {
    override suspend fun execute(input: INPUT, onResult: (OUTPUT) -> Unit) {
        val result = withContext(coroutineScope.io()) {
            executeInBackground(input)
        }
        onResult(result)
    }

    abstract fun executeInBackground(input: INPUT): OUTPUT
}
