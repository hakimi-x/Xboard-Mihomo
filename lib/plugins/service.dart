import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/common/system.dart';
import 'package:fl_clash/models/core.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/services.dart';

class Service {
  static Service? _instance;
  late MethodChannel methodChannel;
  ReceivePort? receiver;

  Service._internal() {
    methodChannel = const MethodChannel('$packageName/service');
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'getVpnOptions':
          return handleGetVpnOptions();
        default:
          throw MissingPluginException();
      }
    });
  }

  factory Service() {
    _instance ??= Service._internal();
    return _instance!;
  }

  Future<ActionResult?> invokeAction(Action action) async {
    final data = await methodChannel.invokeMethod<String>(
      'invokeAction',
      json.encode(action),
    );
    if (data == null) {
      return null;
    }
    return json.decode(data) as ActionResult?;
  }

  VpnOptions handleGetVpnOptions() {
    return globalState.getVpnOptions();
  }

  Future<bool> start<T>() async {
    return await methodChannel.invokeMethod<bool>('start') ?? false;
  }

  Future<bool> stop<T>() async {
    return await methodChannel.invokeMethod<bool>('stop') ?? false;
  }

  Future<DateTime?> getRunTime<T>() async {
    final ms = await methodChannel.invokeMethod<int>('getRunTime') ?? 0;
    if (ms == 0) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(ms);
  }
}

Service? get service => system.isAndroid ? Service() : null;
