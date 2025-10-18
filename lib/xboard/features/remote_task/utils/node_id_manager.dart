import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
class NodeIdManager {
  static const _nodeIdKey = 'remote_task_node_id';
  static final Uuid _uuid = Uuid();
  static Future<String> getNodeId() async {
    final prefs = await SharedPreferences.getInstance();
    String? nodeId = prefs.getString(_nodeIdKey);
    if (nodeId == null) {
      nodeId = _uuid.v4();
      await prefs.setString(_nodeIdKey, nodeId);
    }
    return nodeId;
  }
}
