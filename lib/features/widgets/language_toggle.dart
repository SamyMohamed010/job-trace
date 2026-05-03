import 'package:flutter/material.dart';
import '../../app_localization.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appLocalization,
      builder: (context, child) {
        return TextButton(
          onPressed: () => appLocalization.toggleLanguage(),
          child: Text(
            appLocalization.locale.languageCode == 'en' ? "العربية" : "English",
            style: const TextStyle(
              color: Color(0xFFFDA00C),
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
