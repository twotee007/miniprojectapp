import 'dart:convert';

import 'package:flutter/services.dart';

class Configuration {
  static Future<Map<String, dynamic>> getConfig() {
    return rootBundle.loadString('assets/config/config.json').then(
      (valure) {
        // Json => Map<String>,dynamic<>
        return jsonDecode(valure) as Map<String, dynamic>;
      },
    ).catchError((err) {});
  }
}
