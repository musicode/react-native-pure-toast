package com.github.musicode.toast

import com.facebook.react.bridge.*
import com.github.herokotlin.toast.Toast

class RNTToastModule(private val reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    private val toast = Toast(reactContext)

    override fun getName(): String {
        return "RNTToast"
    }

    @ReactMethod
    fun show(options: ReadableMap) {
        toast.show(
            options.getString("text")!!,
            options.getString("type")!!,
            options.getString("duration")!!,
            options.getString("position")!!
        )
    }

}