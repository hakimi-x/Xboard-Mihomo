package com.follow.clash

import com.follow.clash.common.GlobalState
import com.follow.clash.plugins.AppPlugin
import com.follow.clash.plugins.ServicePlugin
import com.follow.clash.plugins.TilePlugin
import io.flutter.embedding.engine.FlutterEngine
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.launch
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import kotlinx.coroutines.withContext

enum class RunState {
    START, PENDING, STOP
}


object State {

    val runLock = Mutex()

    var runTime: Long = 0

    val runStateFlow: MutableStateFlow<RunState> = MutableStateFlow(RunState.STOP)
    var flutterEngine: FlutterEngine? = null

    val appPlugin: AppPlugin?
        get() = flutterEngine?.plugin<AppPlugin>()

    val servicePlugin: ServicePlugin?
        get() = flutterEngine?.plugin<ServicePlugin>()

    val tilePlugin: TilePlugin?
        get() = flutterEngine?.plugin<TilePlugin>()

    suspend fun handleToggleAction() {
        var action: (suspend () -> Unit)?
        runLock.withLock {
            action = when (runStateFlow.value) {
                RunState.PENDING -> null
                RunState.START -> ::handleStopServiceAction
                RunState.STOP -> ::handleStartServiceAction
            }
        }
        action?.invoke()
    }

    suspend fun handleStartServiceAction() {
        tilePlugin?.let {
            withContext(Dispatchers.Main) {
                it.handleStart()
            }
            return
        }
        handleStartService()
    }

    suspend fun handleStopServiceAction() {
        tilePlugin?.let {
            withContext(Dispatchers.Main) {
                it.handleStop()
            }
            return
        }
        handleStopService()
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
        GlobalState.launch {
            runLock.withLock {
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
        GlobalState.launch {
            runLock.withLock {
                if (runStateFlow.value == RunState.PENDING || runStateFlow.value == RunState.STOP) {
                    return@launch
                }
                runStateFlow.tryEmit(RunState.PENDING)
                servicePlugin?.stopService()
                runStateFlow.tryEmit(RunState.STOP)
                runTime = 0
            }
        }

    }
}


