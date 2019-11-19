package com.github.musicode.toast

import android.os.Build
import com.facebook.react.bridge.*
import android.util.DisplayMetrics
import android.view.Display
import android.content.Context.WINDOW_SERVICE
import android.view.WindowManager
import java.lang.Exception

class RNTToastModule(private val reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "RNTToast"
    }

    @ReactMethod
    fun show(promise: Promise) {


    }

}