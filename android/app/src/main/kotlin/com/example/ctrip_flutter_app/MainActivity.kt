package com.example.ctrip_flutter_app

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import jackhui.org.asr_plugin.AsrPlugin
import org.devio.flutter.splashscreen.SplashScreen

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    SplashScreen.show(this, true);
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    registerSelfPlugin()
  }

  private fun registerSelfPlugin() {
    AsrPlugin.registerWith(registrarFor("jackhui.org.asr_plugin.AsrPlugin"))
  }
}
