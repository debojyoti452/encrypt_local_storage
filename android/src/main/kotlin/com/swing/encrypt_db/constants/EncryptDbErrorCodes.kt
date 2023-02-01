package com.swing.encrypt_db.constants

object EncryptDbErrorCodes {
    val notInitializerError: Pair<String, String> =
        Pair("NOT_INITIALIZED_INSTANCE", "EncryptDb instance is not initialized")

    val invalidArgumentError: Pair<String, String> =
        Pair("INVALID_ARGUMENT", "Invalid argument")

    val invalidMethodError: Pair<String, String> = Pair("INVALID_METHOD", "Invalid method")

    val invalidMethodArgumentError: Pair<String, String> =
        Pair("INVALID_METHOD_ARGUMENT", "Invalid method argument")
}
