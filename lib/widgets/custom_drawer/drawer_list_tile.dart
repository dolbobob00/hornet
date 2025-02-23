import 'package:flutter/material.dart';
class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.name,
    required this.onTap,
    required this.description,
  });
  final String name;
  final String description;
  final VoidCallback onTap;

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
      onTap: onTap,
    );
  }
}
