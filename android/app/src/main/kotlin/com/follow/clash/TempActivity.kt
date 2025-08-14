package com.follow.clash

import android.app.Activity
import android.os.Bundle
import com.follow.clash.common.GlobalState
import com.follow.clash.common.QuickAction
import com.follow.clash.common.value
import kotlinx.coroutines.launch

class TempActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        when (intent.action) {
            QuickAction.START.value -> {
                GlobalState.launch {
                    State.handleStartService()
                }
            }

            QuickAction.STOP.value -> {
                GlobalState.launch {
                    State.handleStopService()
                }
            }

            QuickAction.TOGGLE.value -> {
                GlobalState.launch {
                    State.handleToggleAction()
                }
            }
        }
        finish()
    }
}