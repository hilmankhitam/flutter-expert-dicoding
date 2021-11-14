part of 'commons.dart';


class SslPinning {
  static Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('packages/core/certificates/certificates.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  static Future<http.Client> createLEClient() async {
    final client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    return ioClient;
  }
}

class HttpSSLPinning {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await SslPinning.createLEClient();
  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();
  static Future<void> init() async {
    _clientInstance = await _instance;
  }
}
