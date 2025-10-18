import 'dart:convert';
import 'dart:typed_data';

/// XBoard加密解密工具类
/// 
/// 实现XBoard订阅数据的加密解密功能
/// 解密步骤：Base64解码 → XOR解密 → Base64解码 → (可选)进一步Base64解码
/// 
/// ⚠️ 所有解密密钥从配置文件读取：
/// ```dart
/// final key = await ConfigFileLoaderHelper.getDecryptKey();
/// final result = XBoardDecryptHelper.smartDecrypt(encryptedContent, configuredKey: key);
/// ```
class XBoardDecryptHelper {

  /// XOR解密算法
  /// 
  /// [data] 待解密的字节数组
  /// [key] 解密密钥
  static Uint8List xorDecrypt(Uint8List data, String key) {
    final keyBytes = utf8.encode(key);
    final keyLength = keyBytes.length;
    final result = Uint8List(data.length);
    
    for (int i = 0; i < data.length; i++) {
      result[i] = data[i] ^ keyBytes[i % keyLength];
    }
    
    return result;
  }

  /// 解密XBoard加密的内容
  /// 
  /// [encryptedContent] 加密的内容字符串
  /// [key] 解密密钥（必须提供）
  /// 
  /// 返回解密后的原始内容，如果解密失败返回错误信息
  static String decryptXBoard(String encryptedContent, {required String key}) {
    try {
      // 第一步：Base64解码
      final decoded = base64.decode(encryptedContent);
      
      // 第二步：XOR解密
      final decrypted = xorDecrypt(decoded, key);
      
      // 第三步：Base64解码得到原始内容
      final originalContent = utf8.decode(base64.decode(utf8.decode(decrypted)));
      
      // 第四步：尝试进一步Base64解码
      try {
        final furtherDecoded = utf8.decode(base64.decode(originalContent));
        // 如果成功解码，说明有额外的Base64编码层
        return furtherDecoded;
      } catch (e) {
        // 如果进一步解码失败，返回原始解码结果
        return originalContent;
      }
      
    } catch (e) {
      return '解密失败: $e';
    }
  }

  /// 验证解密结果是否为有效的Clash配置
  /// 
  /// [content] 解密后的内容
  /// 返回true表示是有效的配置格式
  static bool isValidClashConfig(String content) {
    try {
      // 检查是否包含Clash配置的关键字段
      final lines = content.split('\n');
      bool hasProxies = false;
      bool hasRules = false;
      
      for (final line in lines) {
        final trimmed = line.trim();
        if (trimmed.startsWith('proxies:') || trimmed.startsWith('- name:')) {
          hasProxies = true;
        }
        if (trimmed.startsWith('rules:') || trimmed.startsWith('- DOMAIN')) {
          hasRules = true;
        }
      }
      
      // 基本的YAML格式检查
      return hasProxies || hasRules || content.contains('port:');
    } catch (e) {
      return false;
    }
  }

  /// 尝试使用多种密钥解密
  /// 
  /// [encryptedContent] 加密的内容
  /// [keys] 要尝试的密钥列表
  /// 
  /// 返回第一个成功解密且验证通过的结果
  static String decryptWithMultipleKeys(String encryptedContent, List<String> keys) {
    for (final key in keys) {
      try {
        final result = decryptXBoard(encryptedContent, key: key);
        
        // 检查是否解密成功（不是错误信息）
        if (!result.startsWith('解密失败') && isValidClashConfig(result)) {
          return result;
        }
      } catch (e) {
        // 继续尝试下一个密钥
        continue;
      }
    }
    
    return '所有密钥都无法成功解密';
  }

  /// 获取备用解密密钥列表
  /// 
  /// 返回一些常见的备用密钥组合
  /// ⚠️ 仅作为备用，主密钥应从配置文件读取
  static List<String> getFallbackKeys() {
    return [
      'xboard_default_key_2024',
      'xboard_encrypt_key_2024',
      'xboard_subscription_key',
      'xboard_default_encrypt_key',
    ];
  }

  /// 智能解密
  /// 
  /// [encryptedContent] 加密的内容
  /// [configuredKey] 从配置文件读取的密钥（必须提供）
  /// [tryFallback] 是否在配置密钥失败后尝试备用密钥
  /// 
  /// 返回解密结果和使用的密钥信息
  static DecryptResult smartDecrypt(
    String encryptedContent, {
    required String configuredKey,
    bool tryFallback = false,
  }) {
    // 构建密钥列表
    final keys = [
      configuredKey,
      if (tryFallback) ...getFallbackKeys(),
    ];
    
    for (int i = 0; i < keys.length; i++) {
      final key = keys[i];
      try {
        final result = decryptXBoard(encryptedContent, key: key);
        
        if (!result.startsWith('解密失败') && isValidClashConfig(result)) {
          return DecryptResult(
            success: true,
            content: result,
            keyUsed: key,
            keyIndex: i,
            message: i == 0 ? '使用配置密钥解密成功' : '使用备用密钥解密成功',
          );
        }
      } catch (e) {
        // 继续尝试下一个密钥
      }
    }
    
    return DecryptResult(
      success: false,
      content: '',
      keyUsed: null,
      keyIndex: -1,
      message: tryFallback ? '所有解密方式都失败了' : '配置密钥解密失败',
    );
  }
}

/// 解密结果数据类
class DecryptResult {
  final bool success;
  final String content;
  final String? keyUsed;
  final int keyIndex;
  final String message;

  const DecryptResult({
    required this.success,
    required this.content,
    required this.keyUsed,
    required this.keyIndex,
    required this.message,
  });

  @override
  String toString() {
    return 'DecryptResult(success: $success, keyUsed: $keyUsed, message: $message)';
  }
}
