package com.follow.clash.service

import com.follow.clash.common.QuickAction
import com.follow.clash.common.quickIntent
import com.follow.clash.common.toPendingIntent

interface IBaseService {
    fun handleCreate() {
        if (!State.inApp) {
            QuickAction.START.quickIntent.toPendingIntent.send()
        } else {
            State.inApp = false
        }
    }

    fun start()

    fun stop()
}