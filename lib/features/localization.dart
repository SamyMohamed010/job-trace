import 'package:flutter/material.dart';
import '../app_localization.dart';

class AppLocale {
  static String tr(BuildContext context, String key) {
    // Note: This is a simple bridge. If the key is not in the map, it returns the key itself.
    return appLocalization.translate(key);
  }
}
