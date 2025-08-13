package com.follow.clash

import android.app.Application
import com.follow.clash.common.BinderConnection
import com.follow.clash.common.awaitService
import com.follow.clash.common.intent
import com.follow.clash.service.ICallbackInterface
import com.follow.clash.service.IRemoteInterface
import com.follow.clash.service.RemoteService
import com.follow.clash.service.models.VpnOptions
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Deferred
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock


class Service(private val context: Application) :
    CoroutineScope by CoroutineScope(Dispatchers.Default) {
    private val lock = Mutex()

    @Volatile
    private var binderConnectionDeferred: Deferred<BinderConnection<IRemoteInterface.Stub>>? = null

    private suspend fun remote(): IRemoteInterface {
        return getBinderConnection().binder
    }

    private suspend fun getBinderConnection(): BinderConnection<IRemoteInterface.Stub> {
        binderConnectionDeferred?.let { return it.await() }
        return lock.withLock {
            val existing = binderConnectionDeferred
            if (existing != null) {
                existing.await()
            } else {
                val deferred = async {
                    context.awaitService<IRemoteInterface.Stub>(
                        RemoteService::class.intent
                    ).invoke()
                }
                binderConnectionDeferred = deferred
                deferred.await()
            }
        }
    }

    suspend fun unbind() {
        lock.withLock {
            binderConnectionDeferred?.await()?.unbind()
            binderConnectionDeferred = null
        }
    }

    suspend fun invokeAction(
        data: String,
        cb: (result: String?) -> Unit
    ) {
        remote().invokeAction(data, object : ICallbackInterface.Stub() {
            override fun onResult(result: String?) {
                cb(result)
            }
        })
    }

    suspend fun setMessageCallback(
        cb: (result: String?) -> Unit
    ) {
        remote().setMessageCallback(object : ICallbackInterface.Stub() {
            override fun onResult(result: String?) {
                cb(result)
            }
        })
    }

    suspend fun startService(options: VpnOptions, inApp: Boolean) {
        remote().startService(options, inApp)
    }

    suspend fun stopService() {
        remote().stopService()
    }
}