package com.follow.clash.service

import android.app.Service
import android.content.ComponentName
import android.content.Intent
import android.content.ServiceConnection
import android.os.IBinder
import com.follow.clash.common.GlobalState
import com.follow.clash.common.intent
import com.follow.clash.core.Core
import com.follow.clash.service.models.NotificationParams
import com.follow.clash.service.models.VpnOptions

class RemoteService : Service() {
    private var service: IBaseService? = null

    private val connection = object : ServiceConnection {
        override fun onServiceConnected(className: ComponentName, binder: IBinder) {
            service = when (binder) {
                is VpnService.LocalBinder -> binder.getService()
                is CommonService.LocalBinder -> binder.getService()
                else -> throw Exception("invalid binder")
            }
            service?.start()
        }

        override fun onServiceDisconnected(arg: ComponentName) {
            service = null
        }
    }

    private fun handleStopService() {
        service?.stop()
    }

    private fun handleStartService() {
        val origin = when (State.options?.enable == true) {
            true -> VpnService::class
            false -> CommonService::class
        }
        if (service != null && service!!::class == origin) {
            service?.start()
            return
        }
        GlobalState.application.bindService(
            origin.intent, connection, BIND_AUTO_CREATE
        )

    }

    private val binder: IRemoteInterface.Stub = object : IRemoteInterface.Stub() {
        override fun invokeAction(data: String, callback: ICallbackInterface) {
            Core.invokeAction(data, callback::onResult)
        }

        override fun updateNotificationParams(params: NotificationParams?) {
            State.notificationParamsFlow.tryEmit(params)
        }

        override fun startService(
            options: VpnOptions,
            inApp: Boolean
        ) {
            State.options = options
            State.inApp = inApp
            handleStartService()
        }

        override fun stopService() {
            handleStopService()
        }

        override fun setMessageCallback(messageCallback: ICallbackInterface) {
            setMessageCallback(messageCallback::onResult)
        }
    }

    private fun setMessageCallback(cb: (result: String?) -> Unit) {
        Core.setMessageCallback(cb)
    }

    override fun onBind(intent: Intent?): IBinder {
        return binder
    }
}