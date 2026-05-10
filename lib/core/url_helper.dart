// ignore: avoid_web_libraries_in_flutter
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens a URL reliably across all platforms.
/// On Web: uses window.open to open in a new tab (avoids CORS issues).
/// On Mobile/Desktop: uses launchUrl with externalApplication mode.
Future<void> openUrl(String url) async {
  if (url.isEmpty) return;

  final uri = Uri.parse(url);

  if (kIsWeb) {
    // Use url_launcher which calls window.open on web
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault, webOnlyWindowName: '_blank')) {
      // If platform default fails, try externalApplication
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  } else {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
