package com.follow.clash

import com.follow.clash.plugins.AppPlugin
import com.follow.clash.plugins.ServicePlugin
import com.follow.clash.plugins.TilePlugin
import io.flutter.embedding.engine.FlutterEngine
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.launch
import java.util.concurrent.locks.ReentrantLock
import kotlin.concurrent.withLock

enum class RunState {
    START, PENDING, STOP
}


object State : CoroutineScope by CoroutineScope(Dispatchers.IO) {

    val runLock = ReentrantLock()

    var runTime: Long = 0

    val runStateFlow: MutableStateFlow<RunState> = MutableStateFlow(RunState.STOP)
    var flutterEngine: FlutterEngine? = null

    val appPlugin: AppPlugin?
        get() = flutterEngine?.plugin<AppPlugin>()

    val servicePlugin: ServicePlugin?
        get() = flutterEngine?.plugin<ServicePlugin>()

    val tilePlugin: TilePlugin?
        get() = flutterEngine?.plugin<TilePlugin>()

    fun handleToggle() {
        var action: (() -> Unit)?
        runLock.lock()
        try {
            action = when (runStateFlow.value) {
                RunState.PENDING -> null
                RunState.START -> ::handleStartService
                RunState.STOP -> ::handleStopService
            }
        } finally {
            runLock.unlock()
        }
        action?.invoke()
    }

    fun handleStartService() {
        if (appPlugin != null) {
            appPlugin?.requestNotificationsPermission {
                startService()
            }
            return
        }
        startService()
    }

    private fun startService() {
        runLock.withLock {
            launch {
                if (runStateFlow.value == RunState.PENDING || runStateFlow.value == RunState.START) {
                    return@launch
                }
                runStateFlow.tryEmit(RunState.PENDING)
                if (servicePlugin == null) {
                    return@launch
                }
                val options = servicePlugin?.handleGetVpnOptions()
                if (options == null) {
                    return@launch
                }
                appPlugin?.prepare(options.enable) {
                    servicePlugin?.startService(options, true)
                    runStateFlow.tryEmit(RunState.START)
                    runTime = System.currentTimeMillis()
                }
            }
        }
    }

    fun handleStopService() {
        runLock.withLock {
            if (runStateFlow.value == RunState.PENDING || runStateFlow.value == RunState.STOP) {
                return
            }
            runStateFlow.tryEmit(RunState.PENDING)
            servicePlugin?.stopService()
            runStateFlow.tryEmit(RunState.STOP)
            runTime = 0
        }
    }
}


