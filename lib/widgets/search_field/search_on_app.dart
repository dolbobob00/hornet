import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:restful_solid_bloc/src/data/constants.dart';
import 'package:restful_solid_bloc/src/data/repositories/data_anime_repo.dart';
import 'package:restful_solid_bloc/src/domain/anime_tags.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/home_page_cubit/cubit/anime_pics_cubit.dart';
import 'package:restful_solid_bloc/src/theme/app_colors.dart';
import 'package:restful_solid_bloc/src/constants/ui_constants.dart';

class SearchFieldForApp extends StatefulWidget {
  const SearchFieldForApp({super.key});

  @override
  State<SearchFieldForApp> createState() => _SearchFieldForAppState();
}

class _SearchFieldForAppState extends State<SearchFieldForApp> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  List<dynamic> suggestions = GetIt.I<Constants>().appNamedRoutes +
      GetIt.I<IAnimeTags>().getAllAvailableTags;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOverlay();
      } else {
        _hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    _hideOverlay();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(UIConstants.borderRadiusMedium),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: UIConstants.paddingSmall),
              constraints: BoxConstraints(
                maxHeight: 200,
                minWidth: size.width,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius:
                    BorderRadius.circular(UIConstants.borderRadiusMedium),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(UIConstants.alphaLow),
                    blurRadius: UIConstants.shadowBlurRadius,
                    offset: const Offset(0, UIConstants.shadowOffsetSmallY),
                  ),
                ],
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(suggestions[index]),
                  onTap: () {
                    _controller.text = suggestions[index];
                    _hideOverlay();
                    _focusNode.unfocus();
                    _goTo(_controller.text);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _goTo(String text) {
    if (suggestions.contains(text)) {
      if (GetIt.I<Constants>().appNamedRoutes.contains(text)) {
        try {
          context.pushReplacementNamed(
            text,
          );
        } catch (e) {}
      } else {
        try {
          context.pushReplacementNamed(
            'category',
            extra: {
              'tag': text.split(
                ' ',
              ),
            },
          );
        } catch (e) {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: UIConstants.paddingMedium),
      child: CompositedTransformTarget(
        link: _layerLink,
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
              _goTo(_controller.text);
              _hideOverlay();
              _focusNode.unfocus();
            },
            decoration: InputDecoration(
              hintText: 'Search on app',
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
                  _hideOverlay();
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
      ),
    );
  }
}
