package com.swing.encrypt_db.exceptions

abstract class EncryptCoroutinesException(
    open val throwable: Throwable
) : Exception(throwable) {
    constructor(message: String) : this(Throwable(message))
}
