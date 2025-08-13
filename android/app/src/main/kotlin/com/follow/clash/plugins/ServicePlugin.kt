package com.follow.clash.plugins

import com.follow.clash.Service
import com.follow.clash.State
import com.follow.clash.awaitResult
import com.follow.clash.common.Components
import com.follow.clash.common.GlobalState
import com.follow.clash.service.models.VpnOptions
import com.google.gson.Gson
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.launch


class ServicePlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

    private val service = Service(GlobalState.application)
    private lateinit var flutterMethodChannel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterMethodChannel = MethodChannel(
            flutterPluginBinding.binaryMessenger, "${Components.PACKAGE_NAME}/service"
        )
        flutterMethodChannel.setMethodCallHandler(this)
        handleInit()
    }

    override fun onDetachedFromEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        handleUnBind()
        flutterMethodChannel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) = when (call.method) {
        "invokeAction" -> {
            handleInvokeAction(call, result)
        }

        "getRunTime" -> {
            handleGetRunTime(result)
        }

        "start" -> {
            handleStart(result)
        }

        "stop" -> {
            handleStop(result)
        }

        else -> {
            result.notImplemented()
        }
    }

    private fun handleInvokeAction(call: MethodCall, result: MethodChannel.Result) {
        GlobalState.launch {
            val data = call.arguments<String>()!!
            service.invokeAction(data) {
                result.success(it)
            }
        }
    }

    private fun handleStart(result: MethodChannel.Result) {
        State.handleStartService()
        result.success(true)
    }

    private fun handleStop(result: MethodChannel.Result) {
        State.handleStopService()
        result.success(true)
    }

    suspend fun handleGetVpnOptions(): VpnOptions? {
        val res = flutterMethodChannel.awaitResult<String>("getVpnOptions", null)
        return Gson().fromJson(res, VpnOptions::class.java)
    }

    suspend fun startService(options: VpnOptions, inApp: Boolean) {
        service.startService(options, inApp)
    }

    suspend fun stopService() {
        service.stopService()
    }

    fun handleUnBind() {
        GlobalState.launch {
            service.unbind()
        }
    }

    fun handleInit() {
        GlobalState.launch {
            service.setMessageCallback {
                flutterMethodChannel.invokeMethod("message", it)
            }
        }
    }

    private fun handleGetRunTime(result: MethodChannel.Result) {
        return result.success(State.runTime)
    }
}