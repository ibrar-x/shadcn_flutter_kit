package com.example.flutter_shadcn_kit

import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_NAME,
        ).setMethodCallHandler { call, result ->
            if (call.method != "openLink") {
                result.notImplemented()
                return@setMethodCallHandler
            }

            val url = call.argument<String>("url")?.trim().orEmpty()
            if (url.isEmpty()) {
                result.success(false)
                return@setMethodCallHandler
            }

            result.success(openLink(url))
        }
    }

    private fun openLink(url: String): Boolean {
        return try {
            val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url)).apply {
                addCategory(Intent.CATEGORY_BROWSABLE)
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
            }
            if (intent.resolveActivity(packageManager) == null) {
                false
            } else {
                startActivity(intent)
                true
            }
        } catch (_: Exception) {
            false
        }
    }

    private companion object {
        const val CHANNEL_NAME = "shadcn_flutter_kit/markdown_link_opener"
    }
}
