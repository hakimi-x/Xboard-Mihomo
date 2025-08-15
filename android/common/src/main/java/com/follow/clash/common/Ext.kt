package com.follow.clash.common

import android.annotation.SuppressLint
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.BroadcastReceiver
import android.content.ComponentName
import android.content.Context
import android.content.Context.RECEIVER_NOT_EXPORTED
import android.content.Intent
import android.content.IntentFilter
import android.content.ServiceConnection
import android.content.pm.ServiceInfo.FOREGROUND_SERVICE_TYPE_DATA_SYNC
import android.os.Build
import android.os.IBinder
import android.os.RemoteException
import android.util.Log
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import kotlin.reflect.KClass

//fun Context.startForegroundServiceCompat(intent: Intent?) {
//    if (Build.VERSION.SDK_INT >= 26) {
//        startForegroundService(intent)
//    } else {
//        startService(intent)
//    }
//}

val KClass<*>.intent: Intent
    get() = Intent(GlobalState.application, this.java)

fun Service.startForegroundCompat(id: Int, notification: Notification) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
        startForeground(id, notification, FOREGROUND_SERVICE_TYPE_DATA_SYNC)
    } else {
        startForeground(id, notification)
    }
}

val QuickAction.value: String
    get() = "${GlobalState.application.packageName}.action.${this@value.name}"

val QuickAction.quickIntent: Intent
    get() = Intent().apply {
        Log.d("[quickIntent]", Components.TEMP_ACTIVITY.toString())
        setComponent(Components.TEMP_ACTIVITY)
        action = this@quickIntent.value
        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_MULTIPLE_TASK)
    }

val Intent.toPendingIntent: PendingIntent
    get() = PendingIntent.getActivity(
        GlobalState.application,
        0,
        this,
        PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
    )


fun Service.startForeground(notification: Notification) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        val manager = getSystemService(NotificationManager::class.java)
        var channel = manager?.getNotificationChannel(GlobalState.NOTIFICATION_CHANNEL)
        if (channel == null) {
            channel = NotificationChannel(
                GlobalState.NOTIFICATION_CHANNEL,
                "SERVICE_CHANNEL",
                NotificationManager.IMPORTANCE_LOW
            )
            manager?.createNotificationChannel(channel)
        }
    }
    startForegroundCompat(GlobalState.NOTIFICATION_ID, notification)
}

@SuppressLint("UnspecifiedRegisterReceiverFlag")
fun Context.registerReceiverCompat(
    receiver: BroadcastReceiver,
    filter: IntentFilter,
) = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
    registerReceiver(receiver, filter, RECEIVER_NOT_EXPORTED)
} else {
    registerReceiver(receiver, filter)
}

fun Context.receiveBroadcastFlow(
    configure: IntentFilter.() -> Unit,
): Flow<Intent> = callbackFlow {
    val filter = IntentFilter().apply(configure)
    val receiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (context == null || intent == null) return
            trySend(intent)
        }
    }
    registerReceiverCompat(receiver, filter)
    awaitClose { unregisterReceiver(receiver) }
}


inline fun <reified T : IBinder> Context.bindServiceFlow(
    intent: Intent,
    flags: Int = Context.BIND_AUTO_CREATE,
    noinline onCrash: (() -> Unit)? = null,
): Flow<T?> = callbackFlow {
    var currentBinder: IBinder? = null
    val deathRecipient = IBinder.DeathRecipient {
        onCrash?.invoke()
        trySend(null)
    }
    val connection = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName?, binder: IBinder?) {
            if (binder != null) {
                try {
                    binder.linkToDeath(deathRecipient, 0)
                    currentBinder = binder
                    @Suppress("UNCHECKED_CAST")
                    val casted = binder as? T
                    if (casted != null) {
                        trySend(casted)
                    } else {
                        Log.d("[BindService]", "Binder is not of type ${T::class.java}")
                        trySend(null)
                    }
                } catch (e: RemoteException) {
                    Log.d("[BindService]", "Failed to link to death: ${e.message}")
                    binder.unlinkToDeath(deathRecipient, 0)
                    trySend(null)
                }
            } else {
                trySend(null)
            }
        }

        override fun onServiceDisconnected(name: ComponentName?) {
            Log.d("[BindService]", "Service disconnected")
            currentBinder?.unlinkToDeath(deathRecipient, 0)
            currentBinder = null
            trySend(null)
        }
    }

    if (!bindService(intent, connection, flags)) {
        Log.d("[BindService]", "Failed to bind service")
        trySend(null)
        close()
        return@callbackFlow
    }

    awaitClose {
        currentBinder?.unlinkToDeath(deathRecipient, 0)
        runCatching { unbindService(connection) }
    }
}


val Long.formatBytes: String
    get() {
        val units = arrayOf("B", "KB", "MB", "GB", "TB")
        var size = this.toDouble()
        var unitIndex = 0

        while (size >= 1024 && unitIndex < units.size - 1) {
            size /= 1024
            unitIndex++
        }

        return if (unitIndex == 0) {
            "${size.toLong()}${units[unitIndex]}"
        } else {
            "%.1f${units[unitIndex]}".format(size)
        }
    }