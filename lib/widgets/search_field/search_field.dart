
import 'package:restful_solid_bloc/src/presentation/cubit/home_page_cubit/cubit/anime_pics_cubit.dart';

import '../../src/presentation/pages/home_page/home_page_imports.dart';
import '../../src/theme/ui_constants.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AnimePicsCubit>(context);
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: UIConstants.paddingMedium),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusLarge),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(UIConstants.alphaLow),
              blurRadius: UIConstants.shadowBlurRadius,
              spreadRadius: UIConstants.shadowSpreadRadius,
              offset: const Offset(0, UIConstants.shadowOffsetY),
            ),
          ],
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onSubmitted: (value) {
            bloc.fetchFromRule34(
              tag: value,
              page: GetIt.I<IAnimeTags>().pageValue,
            );
          },
          decoration: InputDecoration(
            hintText: 'Search for waifu',
            prefixIcon: Icon(
              Icons.search,
              weight: 0.1,
              opticalSize: 1,
              color: AppColors.primaryBlack,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();

                _focusNode.unfocus();
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide: BorderSide(
                color: Colors.grey.withAlpha(30),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
