import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/plugins/service.dart';
import 'package:fl_clash/state.dart';

import 'system.dart';

class Android {
  Future<void> init() async {
    await service?.init();
    app?.onExit = () async {
      await globalState.appController.savePreferences();
    };
  }
}

final android = system.isAndroid ? Android() : null;
