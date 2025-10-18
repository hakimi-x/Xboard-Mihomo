import 'package:fl_clash/clash/clash.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/xboard/xboard.dart';

class LatencyService {
  LatencyService();
  
  Future<Map<String, int>> testNodes(List<Proxy> nodes) async {
    final Map<String, int> latencies = {};
    if (nodes.isEmpty) {
      return latencies;
    }
    
    // 从配置文件获取延迟测试URL（开源友好：可在 xboard.config.json 中配置）
    final testUrl = await ConfigFileLoaderHelper.getLatencyTestUrl();
    final List<Future> tasks = [];
    for (final node in nodes) {
      tasks.add(
        clashCore.getDelay(testUrl, node.name).then((delay) {
          latencies[node.name] = delay.value ?? -1;
        }).catchError((_) {
          latencies[node.name] = -1;
        }),
      );
    }
    await Future.wait(tasks);
    return latencies;
  }
}
final latencyServiceProvider = Provider<LatencyService>((ref) {
  return LatencyService();
});