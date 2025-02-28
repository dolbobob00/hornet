import 'package:flutter/material.dart';

class ErrorHandlerAnimePictures extends StatelessWidget {
  const ErrorHandlerAnimePictures({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Problem was caught.',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.red,
              ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Try to clear tag\'s, add tag\'s by one per time, sometimes base doesnt have multiple tag\'s like \n "Maid + Gif + Oppai"',
            maxLines: 3,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        ExpansionTile(
          leading: Icon(
            Icons.error,
          ),
          iconColor: Theme.of(context).colorScheme.error,
          title: Text(
            'See full error code',
          ),
          children: [
            Text(
              message,
            ),
          ],
        ),
      ],
    );
  }
}
