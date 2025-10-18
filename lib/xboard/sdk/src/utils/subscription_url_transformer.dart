abstract class SubscriptionUrlTransformer {
  String transformUrl(String originalUrl);
  bool isValidUrl(String url);
}
class BaseSubscriptionUrlTransformer implements SubscriptionUrlTransformer {
  static const String _subscriptionPath = '/api/v1/subscription';
  static const String _originalPath = '/s/';
  @override
  String transformUrl(String originalUrl) {
    if (!isValidUrl(originalUrl)) {
      throw ArgumentError('Invalid subscription URL format: $originalUrl');
    }
    final uri = Uri.parse(originalUrl);
    final token = _extractToken(originalUrl);
    final newUri = Uri(
      scheme: uri.scheme,
      host: uri.host,
      port: uri.hasPort ? uri.port : null,
      path: '$_subscriptionPath/$token',
    );
    return newUri.toString();
  }
  @override
  bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && 
             uri.hasAuthority && 
             url.contains(_originalPath);
    } catch (e) {
      return false;
    }
  }
  String _extractToken(String originalUrl) {
    final pathIndex = originalUrl.indexOf(_originalPath);
    if (pathIndex == -1) {
      throw ArgumentError('URL does not contain expected path: $_originalPath');
    }
    final token = originalUrl.substring(pathIndex + _originalPath.length);
    if (token.isEmpty) {
      throw ArgumentError('No token found in URL');
    }
    return token;
  }
}
class EncryptedSubscriptionUrlTransformer implements SubscriptionUrlTransformer {
  final SubscriptionUrlTransformer _baseTransformer;
  final SubscriptionUrlEncryptor _encryptor;
  EncryptedSubscriptionUrlTransformer(this._baseTransformer, this._encryptor);
  @override
  String transformUrl(String originalUrl) {
    final baseUrl = _baseTransformer.transformUrl(originalUrl);
    return _encryptor.encrypt(baseUrl);
  }
  @override
  bool isValidUrl(String url) {
    return _baseTransformer.isValidUrl(url);
  }
}
abstract class SubscriptionUrlEncryptor {
  String encrypt(String url);
  String decrypt(String encryptedUrl);
}
class SubscriptionUrlTransformerFactory {
  static SubscriptionUrlTransformer createBasic() {
    return BaseSubscriptionUrlTransformer();
  }
  static SubscriptionUrlTransformer createWithEncryption(
    SubscriptionUrlEncryptor encryptor,
  ) {
    return EncryptedSubscriptionUrlTransformer(
      BaseSubscriptionUrlTransformer(),
      encryptor,
    );
  }
}