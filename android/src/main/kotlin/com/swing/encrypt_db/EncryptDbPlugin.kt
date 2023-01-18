package com.swing.encrypt_db

import android.annotation.SuppressLint
import androidx.annotation.NonNull
import com.swing.encrypt_db.constants.AppConstants
import com.swing.encrypt_db.constants.AppConstants.CHANNEL_NAME
import com.swing.encrypt_db.constants.AppConstants.METHOD_GET_PLATFORM_VERSION
import com.swing.encrypt_db.constants.AppConstants.METHOD_SET_DATA

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** EncryptDbPlugin */
@SuppressLint("KotlinNullnessAnnotation")
class EncryptDbPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var encryptDb: EncryptDb

    private fun initializePlugin(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        encryptDb = EncryptDb(flutterPluginBinding.applicationContext)
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL_NAME)
        channel.setMethodCallHandler(this)
    }
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        initializePlugin(flutterPluginBinding)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            METHOD_SET_DATA -> {
                val data = call.argument<String>(METHOD_SET_DATA)
                result.success(data)
            }
            METHOD_GET_PLATFORM_VERSION -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
