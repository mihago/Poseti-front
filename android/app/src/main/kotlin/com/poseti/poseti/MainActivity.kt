package com.poseti.poseti
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
// Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("7c1c7db8-406d-45ea-aec8-7b4f8a77b5c3") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}
