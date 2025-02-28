
import 'package:go_router/go_router.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/animations_cubit/cubit/animations_cubit.dart';
import 'package:restful_solid_bloc/src/presentation/pages/search_page/search_page_imports.dart';

import '../animations/animated_icon.dart';
import 'drawer_list_tile.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.entry});
  final MapEntry<String, dynamic> entry;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AnimationsCubit>(context);
    return ExpansionTile(
      onExpansionChanged: (value) {
        bloc.mustProvideAnimation(
          value: value,
        );
      },
      leading: CustomAnimatedIcon(
        animIcon: AnimatedIcons.list_view,
        size: 24,
      ),
      title: Text(_capitalizeFirstLetter(entry.key)),
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
