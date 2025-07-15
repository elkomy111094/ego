import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  Future<void> openUrl({required String url}) async {
    try {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } catch (ex) {}
  }
}
