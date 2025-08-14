package com.follow.clash.common

import android.content.Context
import android.content.Intent
import android.os.IBinder
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.launch
import kotlinx.coroutines.withTimeoutOrNull

class ServiceDelegate<T>(
    private val context: Context,
    private val intent: Intent,
    private val interfaceCreator: (IBinder) -> T
) : CoroutineScope by CoroutineScope(SupervisorJob() + Dispatchers.Default) {

    private val _service = MutableStateFlow<T?>(null)

    val service: StateFlow<T?> = _service

    fun bind() {
        launch {
            context.bindServiceFlow<IBinder>(intent)
                .collect { binder ->
                    _service.value = binder?.let(interfaceCreator)
                }
        }
    }

    suspend inline fun <R> useService(crossinline block: (T) -> R): Result<R> {
        return withTimeoutOrNull(10_000) {
            service.first { it != null }
        }?.let { service ->
            try {
                Result.success(block(service))
            } catch (e: Exception) {
                Result.failure(e)
            }
        } ?: Result.failure(Exception("Service connection timeout"))
    }

    fun unbind() {
        _service.value = null
        cancel()
    }
}