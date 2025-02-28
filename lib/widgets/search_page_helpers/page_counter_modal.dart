import 'package:flutter/material.dart';

import 'page_counter.dart';

class PageCounterModal extends StatelessWidget {
  const PageCounterModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        border: Border.all(),
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PageCounterRow(),
        ],
      ),
    );
  }
}
