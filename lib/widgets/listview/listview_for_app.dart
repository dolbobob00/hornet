import 'package:flutter/material.dart';
import 'package:restful_solid_bloc/widgets/listview/listview_tile.dart';

class ListViewForApp extends StatelessWidget {
  const ListViewForApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListViewTile(
            title: index.toString() + 'na',
            subtitle: index.toString() + 'sadsd',
          ),
        );
      },
    );
  }
}
