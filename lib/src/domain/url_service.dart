import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class IUrlService {
  Future<void> shareNetworkImage({required String imageUrl, String? text});
  Future<void> shareUri({required String imageUrl});
  Future<void> launchURL({required String imageUrlOrSource});
}

class UrlServiceImpl implements IUrlService {
  final Dio _dio = GetIt.I<Dio>();

  @override
  Future<void> launchURL({required String imageUrlOrSource}) async {
    final Uri url = Uri.parse(imageUrlOrSource);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Future<void> shareUri({required String imageUrl}) async {
    await Share.shareUri(Uri.parse(imageUrl));
  }

  String _getFileExtension(String url, Map<String, List<String>>? headers) {
    final Uri uri = Uri.parse(url);
    final String path = uri.path.toLowerCase();

    // First try to get from Content-Type
    if (headers != null && headers['content-type'] != null) {
      final contentType = headers['content-type']!.first.toLowerCase();
      if (contentType.contains('gif')) return '.gif';
      if (contentType.contains('jpeg') || contentType.contains('jpg')) {
        return '.jpg';
      }
      if (contentType.contains('png')) return '.png';
      if (contentType.contains('webp')) return '.webp';
    }

    // Fallback to URL path analysis
    if (path.endsWith('.gif')) return '.gif';
    if (path.endsWith('.jpg') || path.endsWith('.jpeg')) return '.jpg';
    if (path.endsWith('.png')) return '.png';
    if (path.endsWith('.webp')) return '.webp';

    return '.jpg'; // Default extension
  }

  @override
  Future<void> shareNetworkImage({
    required String imageUrl,
    String? text,
  }) async {
    try {
      final response = await _dio.get<List<int>>(
        imageUrl,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
        ),
      );
  //check
  
      if (response.data == null) {
        await shareUri(imageUrl: imageUrl);
        return;
      }

      final String fileExtension =
          _getFileExtension(imageUrl, response.headers.map);

      final Directory directory = await getTemporaryDirectory();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String filepath =
          '${directory.path}/Image_$timestamp$fileExtension';

      final File file = File(filepath);
      await file.writeAsBytes(response.data!);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: text,
      );
    } catch (e) {
      await shareUri(imageUrl: imageUrl);
    }
  }
}
