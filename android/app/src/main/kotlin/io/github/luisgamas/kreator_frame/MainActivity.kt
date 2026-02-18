package io.github.luisgamas.kreator_frame

import android.os.Handler
import android.os.Looper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val channelName = "kreator_frame/wallpaper"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "setWallpaper" -> {
                        val url = call.argument<String>("url") ?: run {
                            result.error("INVALID_ARGS", "url is required", null)
                            return@setMethodCallHandler
                        }
                        val location = call.argument<Int>("location") ?: 1

                        Thread {
                            try {
                                val service = WallpapersNativeServices(applicationContext)
                                val success = service.applyWallpaper(url, location)
                                Handler(Looper.getMainLooper()).post {
                                    result.success(success)
                                }
                            } catch (e: Exception) {
                                Handler(Looper.getMainLooper()).post {
                                    result.error("WALLPAPER_ERROR", e.message, null)
                                }
                            }
                        }.start()
                    }

                    "openNativeWallpaperPicker" -> {
                        val url = call.argument<String>("url") ?: run {
                            result.error("INVALID_ARGS", "url is required", null)
                            return@setMethodCallHandler
                        }

                        Thread {
                            try {
                                val service = WallpapersNativeServices(applicationContext)
                                val intent = service.prepareNativeWallpaperIntent(url)
                                Handler(Looper.getMainLooper()).post {
                                    startActivity(intent)
                                    result.success(true)
                                }
                            } catch (e: Exception) {
                                Handler(Looper.getMainLooper()).post {
                                    result.error("WALLPAPER_ERROR", e.message, null)
                                }
                            }
                        }.start()
                    }

                    "openWallpaperChooser" -> {
                        val url = call.argument<String>("url") ?: run {
                            result.error("INVALID_ARGS", "url is required", null)
                            return@setMethodCallHandler
                        }

                        Thread {
                            try {
                                val service = WallpapersNativeServices(applicationContext)
                                val intent = service.prepareWallpaperChooserIntent(url)
                                Handler(Looper.getMainLooper()).post {
                                    startActivity(intent)
                                    result.success(true)
                                }
                            } catch (e: Exception) {
                                Handler(Looper.getMainLooper()).post {
                                    result.error("WALLPAPER_ERROR", e.message, null)
                                }
                            }
                        }.start()
                    }

                    else -> result.notImplemented()
                }
            }
    }
}
