

abstract class IDownloader {
  void downloadFileFromUrl({required String url, String? name});
}

class FileDownloaderImpl implements IDownloader {
  @override
  void downloadFileFromUrl({
    required String url,
    String? name,
  }) async {}
}
