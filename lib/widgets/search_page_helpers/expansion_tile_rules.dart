import 'package:flutter/material.dart';

import 'expansion_with_rules_text.dart';

class ExpansionTileRules extends StatelessWidget {
  const ExpansionTileRules({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Rules of tag writing',
          ),
          Icon(
            Icons.info,
          ),
        ],
      ),
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(
              25,
            ),
          ),
          child: ExpansionWithRules(),
        ),
      ],
    );
  }
}
