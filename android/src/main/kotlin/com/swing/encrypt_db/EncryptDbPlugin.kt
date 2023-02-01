package com.swing.encrypt_db

import android.annotation.SuppressLint
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin

/** EncryptDbPlugin */
@SuppressLint("KotlinNullnessAnnotation")
class EncryptDbPlugin : FlutterPlugin {

    private var methodHandlerImpl: MethodHandlerImpl? = null

    private fun initializePlugin(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        methodHandlerImpl = MethodHandlerImpl(
            flutterPluginBinding.binaryMessenger,
            flutterPluginBinding
        )
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        initializePlugin(flutterPluginBinding)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        methodHandlerImpl.let {
            it?.dispose()
            methodHandlerImpl = null
        }
    }
}
