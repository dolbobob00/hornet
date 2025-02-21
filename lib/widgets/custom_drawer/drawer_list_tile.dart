import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.name,
    required this.description,
  });
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 32.0),
      title: Text(
        name,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        description,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        context.goNamed(
          'category',
          extra: name,
        );
        Navigator.pop(context);
      },
    );
  }
}
