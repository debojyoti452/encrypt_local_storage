package com.swing.encrypt_db.utils

import java.util.*

object Extensions {
    fun Enum<*>.toValue(): String {
        return this.name.lowercase(Locale.getDefault())
    }
}
