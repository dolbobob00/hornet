import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'drawer_list_tile.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.entry});
  final MapEntry<String, dynamic> entry;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.category),
      title: Text(entry.key),
      children: (entry.value as List)
          .map<Widget>(
            (item) => Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              child: DrawerListTile(
                name: _capitalizeFirstLetter(item['name'].toString()),
                description: item['description'],
                onTap: () {
                  context.goNamed(
                    'category',
                    extra: _capitalizeFirstLetter(
                      item['name'].toString(),
                    ),
                  );
                },
              ),
            ),
          )
          .toList(),
    );
  }

  String _capitalizeFirstLetter(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }
}
