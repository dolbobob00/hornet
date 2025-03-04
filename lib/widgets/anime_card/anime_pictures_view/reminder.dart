import 'package:flutter/material.dart';

class ReminderAboutNsfw extends StatelessWidget {
  const ReminderAboutNsfw({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(
          25,
        ),
      ),
      child: Text(
        'Just reminder! This is a NSFW content!',
        style: TextStyle(
          fontSize: 24,
          color: Colors.red,
        ),
      ),
    );
  }
}
