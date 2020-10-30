import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:universal_html/html.dart';

Future<String> getStorage(String key) async {
  if (kIsWeb) {
    String val = window.localStorage[key];
    return val;
  } else {
    FlutterSecureStorage storage = FlutterSecureStorage();
    final val = await storage.read(key: key);
    return val;
  }
}

Future storeStorage(String key, String val) async {
  if (kIsWeb) {
    window.localStorage[key] = val;
  } else {
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: key, value: val);
  }
}

Future removeStorage(String key) async {
  if (kIsWeb) {
    window.localStorage.remove(key);
  } else {
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.delete(key: key);
  }
}

Future<Map<String, dynamic>> readAll() async {
  if (kIsWeb) {
    return window.localStorage;
  } else {
    FlutterSecureStorage storage = FlutterSecureStorage();
    final val = await storage.readAll();
    return val;
  }
}
