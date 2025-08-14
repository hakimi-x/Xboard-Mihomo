package com.follow.clash

import android.app.Application
import com.follow.clash.common.ServiceDelegate
import com.follow.clash.common.intent
import com.follow.clash.service.ICallbackInterface
import com.follow.clash.service.IRemoteInterface
import com.follow.clash.service.RemoteService
import com.follow.clash.service.models.VpnOptions

class Service(context: Application) {
    private val delegate = ServiceDelegate<IRemoteInterface>(
        context, RemoteService::class.intent
    ) {
        IRemoteInterface.Stub.asInterface(it)
    }


    suspend fun bind(): Boolean {
        delegate.bind()
        delegate.useService {
            return@useService true
        }
        return false
    }

    fun unbind() {
        delegate.unbind()
    }

    suspend fun invokeAction(
        data: String, cb: (result: String?) -> Unit
    ) {
        delegate.useService {
            it.invokeAction(data, object : ICallbackInterface.Stub() {
                override fun onResult(result: String?) {
                    cb(result)
                }
            })
        }
    }

    suspend fun setMessageCallback(
        cb: (result: String?) -> Unit
    ) {
        delegate.useService {
            it.setMessageCallback(object : ICallbackInterface.Stub() {
                override fun onResult(result: String?) {
                    cb(result)
                }
            })
        }
    }

    suspend fun startService(options: VpnOptions, inApp: Boolean) {
        delegate.useService { it.startService(options, inApp) }
    }


    suspend fun stopService() {
        delegate.useService { it.stopService() }
    }
}