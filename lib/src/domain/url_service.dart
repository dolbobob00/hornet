import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class IUrlService {
  Future<void> shareNetworkImage({required String imageUrl, String? text});
  void shareUri({required String imageUrl});
  void launchURL({required String imageUrlOrSource});
}

class UrlServiceImpl implements IUrlService {
  @override
  void launchURL({required String imageUrlOrSource}) async {
    final Uri url = Uri.parse(imageUrlOrSource);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void shareUri({required String imageUrl}) async {
    Share.shareUri(Uri.parse(imageUrl));
  }

  String _getFileExtension(String url) {
    final Uri uri = Uri.parse(url);
    final String path = uri.path.toLowerCase();
    if (path.endsWith('.gif')) return '.gif';
    if (path.endsWith('.jpg') || path.endsWith('.jpeg')) return '.jpg';
    if (path.endsWith('.png')) return '.png';
    if (path.endsWith('.webp')) return '.webp';
    return '.jpg';
  }

  @override
  Future<void> shareNetworkImage({
    required String imageUrl,
    String? text,
  }) async {
    try {
      final http.Response response = await http.get(Uri.parse(imageUrl));
      final String fileExtension = _getFileExtension(imageUrl);

      // Проверяем Content-Type если расширение не определено из URL
      if (fileExtension == '.jpg' && response.headers['content-type'] != null) {
        final contentType = response.headers['content-type']!.toLowerCase();
        if (contentType.contains('gif')) return shareUri(imageUrl: imageUrl);
        if (contentType.contains('webp')) return shareUri(imageUrl: imageUrl);
      }

      final Directory directory = await getTemporaryDirectory();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String filepath = '${directory.path}/Image_$timestamp$fileExtension';

      final File file = await File(filepath).writeAsBytes(response.bodyBytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: text,
      );
    } catch (e) {
      // Fallback to simple URL sharing if file sharing fails
      shareUri(imageUrl: imageUrl);
    }
  }
}
