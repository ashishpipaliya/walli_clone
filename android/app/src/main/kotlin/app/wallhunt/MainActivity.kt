package app.wallhunt

import android.annotation.SuppressLint
import android.app.Application
import android.app.NotificationManager
import android.content.Context
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    val channelName: String  = "app.wallhunt"

    private var mResult: MethodChannel.Result? = null
    private var channel: MethodChannel? = null
    @SuppressLint("LongLogTag")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        val options: HashMap<String, Any> = HashMap()
//
//        options.put(Bugsee.Option.ExtendedVideoMode, true);
//        Bugsee.launch(this.application, "7c0ccf78-68b6-4ed6-a0e6-2e7051ba9d5c", options);
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
        channel!!.setMethodCallHandler { call, result ->
            this.onMethodCall(call, result)
        }
    }

    fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        mResult = result
        Log.v("Call Method", call.method)
        when {
            call.method == "test" -> {
                result.success("test")
            }
            call.method == "clearNotification" -> {
                val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
                notificationManager.cancelAll()
                result.success("clearNotification")
            }
            else -> result.notImplemented()
        }
    }
}

