import 'package:restful_solid_bloc/src/domain/local_database.dart';
import 'package:restful_solid_bloc/src/presentation/pages/home_page/home_page_imports.dart';

abstract class IAnimeTags {
  List<String> get tags;
  bool get showGif;
  bool get showNSFW;
  int get pageValue;

  set allAvailableTags(List<String> allTags);
  List<String> get getAllAvailableTags;
  set changeAllTagsTo(List<String> value);

  set changeShowGif(bool value);

  set changeShowNSFW(bool value);

  set setLastTag(Map<String, dynamic> lastCheckedTag);

  Map<String, dynamic> get getLastCheckedTag;

  void changeAmountOfPages({required int whatIncOrDec});

  void clearTags({List<String>? exceptTags}) {}

  void addTag({required String tag}) {}

  void clearAmountOfPages();

  void deleteTag({required String tag}) {}
}

class AnimeTagsImpl implements IAnimeTags {
  List<String> _tags = [];
  bool _showGif = false;
  bool _showNSFW = true;
  int _page = 1;
  List<String> allTags = [];
  Map<String, dynamic> savedLastTagChecked = {
    'route': 'search',
    'tag': null,
    'preview_url':
        'https://steamuserimages-a.akamaihd.net/ugc/187291001665850410/70264D31640E4F5D80F2B27B4AFBE076AE0F9AE2/?imw=512&amp;imh=287&amp;ima=fit&amp;impolicy=Letterbox&amp;imcolor=%23000000&amp;letterbox=true'
  };
  @override
  set setLastTag(Map<String, dynamic> lastCheckedTag) {
    GetIt.I<ILocalDatabase>().writeData(
      'lastTag',
      lastCheckedTag,
    );
    savedLastTagChecked = lastCheckedTag;
  }

  @override
  Map<String, dynamic> get getLastCheckedTag => savedLastTagChecked;

  @override
  List<String> get tags => _tags;

  @override
  bool get showGif => _showGif;

  @override
  bool get showNSFW => _showNSFW;
  @override
  set changeAllTagsTo(List<String> value) => _tags = value;

  @override
  void clearTags({List<String>? exceptTags}) {
    if (exceptTags != null) {
      _tags.removeWhere(
        (element) => !exceptTags.contains(element),
      );
    } else {
      _tags.clear();
    }
  }

  @override
  void addTag({required String tag}) {
    if (_tags.contains(tag)) return;
    _tags.add(tag);
  }

  @override
  void deleteTag({required String tag}) {
    _tags.remove(tag);
  }

  @override
  set changeShowGif(bool value) {
    _showGif = value;
  }

  @override
  set changeShowNSFW(bool value) {
    _showNSFW = value;
  }

  @override
  int get pageValue => _page;

  @override
  void clearAmountOfPages() {
    _page = 0;
  }

  @override
  void changeAmountOfPages({required int whatIncOrDec}) {
    if (_page < -1) {
      _page = -1;
      return;
    }
    _page += whatIncOrDec;
  }

  @override
  set allAvailableTags(List<String> allTags) {
    this.allTags = allTags;
  }

  @override
  List<String> get getAllAvailableTags => allTags;
}
