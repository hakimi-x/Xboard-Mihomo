package com.follow.clash

import android.app.Activity
import android.os.Bundle
import com.follow.clash.common.QuickAction
import com.follow.clash.common.value

class TempActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        when (intent.action) {
            QuickAction.START.value -> {
                State.handleStartService()
            }

            QuickAction.STOP.value -> {
                State.handleStopService()
            }

            QuickAction.TOGGLE.value -> {
                State.handleToggle()
            }
        }
        finish()
    }
}