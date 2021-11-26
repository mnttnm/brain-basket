import "dart:convert";

String configToJsonString(Map<String, dynamic> config) {
  return jsonEncode(config);
}

class ConfigHandler {
  static ConfigHandler? _configHandler;
  late Map<String, dynamic>? _config;

  void initialiseConfig() {
    const jsonConfig = String.fromEnvironment("APP_CONFIG");
    final decodedConfig = utf8.decode(base64.decode(jsonConfig));
    _config = jsonDecode(decodedConfig) as Map<String, dynamic>;
  }

  Map<String, dynamic> get razorpayConfig {
    return _config?['razorpayConfig'] as Map<String, dynamic>;
  }

  Map<String, dynamic> get shiprocketConfig {
    return _config?['shiprocketConfig'] as Map<String, dynamic>;
  }

  factory ConfigHandler() {
    return _configHandler ?? ConfigHandler._internal();
  }

  ConfigHandler._internal() {
    initialiseConfig();
  } // private constructor
}
