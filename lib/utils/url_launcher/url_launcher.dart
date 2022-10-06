import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static launchLink(String url) async {
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      throw 'Could not launch $url';
    }
  }
}
