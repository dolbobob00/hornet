abstract class IAnimeTags {
  List<String> get tags;
  bool get showGif;
  bool get showNSFW;
  int get pageValue;
  set changeAllTagsTo(List<String> value);

  set changeShowGif(bool value);

  set changeShowNSFW(bool value);

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
  void clearAmountOfPages(){
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
}
