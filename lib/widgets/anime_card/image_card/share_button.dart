import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:restful_solid_bloc/src/domain/url_service.dart';

class ShareButton extends StatefulWidget {
  const ShareButton({super.key, required this.url, this.text});
  final String url;
  final String? text;

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  Widget icon = Icon(Icons.share);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: icon,
        onPressed: () async {
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          try {
            setState(() {
              icon = CircularProgressIndicator.adaptive();
            });
            await GetIt.I<IUrlService>().shareNetworkImage(
              imageUrl: widget.url,
              text: widget.text,
            );
          } catch (e) {
            if (!mounted) return;
            scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text(
                  e.toString(),
                ),
              ),
            );
          }
          setState(() {
            icon = Icon(
              Icons.share,
            );
          });
        });
  }
}
