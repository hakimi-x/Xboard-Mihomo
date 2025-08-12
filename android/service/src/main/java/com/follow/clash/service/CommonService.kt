package com.follow.clash.service

import android.app.Service
import android.content.Intent
import android.os.Binder
import android.os.IBinder
import com.follow.clash.core.Core
import com.follow.clash.service.modules.NetworkObserveModule
import com.follow.clash.service.modules.NotificationModule

class CommonService : Service(), IBaseService {
    val notificationModule = NotificationModule(this)
    val networkObserveModule = NetworkObserveModule(this)

    override fun onCreate() {
        super.onCreate()
        handleCreate()
    }

    override fun onLowMemory() {
        Core.forceGC()
        super.onLowMemory()
    }

    private val binder = LocalBinder()

    inner class LocalBinder : Binder() {
        fun getService(): CommonService = this@CommonService
    }

    override fun onBind(intent: Intent): IBinder {
        return binder
    }

    override fun start() {
        notificationModule.install()
        networkObserveModule.install()

    }

    override fun stop() {
        notificationModule.uninstall()
        notificationModule.uninstall()
        stopSelf()
    }
}