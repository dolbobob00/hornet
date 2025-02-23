import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton({super.key, required this.url});
  final String url;
  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  Widget icon = Icon(
    Icons.download,
  );
  double? _progress;
  @override
  Widget build(BuildContext context) {
    return _progress != null && _progress! < 101
        ? Column(
            children: [
              CircularProgressIndicator(),
              Text(
                '${_progress!.toInt()}%',
              ),
            ],
          )
        : IconButton(
            onPressed: () {
              FileDownloader.downloadFile(
                url: widget.url,
                onDownloadCompleted: (path) {
                  setState(() {
                    icon = Icon(
                      Icons.download_done,
                    );
                    _progress = null;
                  });
                },
                onProgress: (fileName, progress) {
                  setState(() {
                    _progress = progress;
                  });
                },
              );
            },
            icon: icon,
          );
  }
}
