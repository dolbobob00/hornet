abstract class IAnimeTags {
  List<String> get tags;
  bool get showGif;
  bool get showNSFW;
  set changeAllTagsTo(List<String> value);

  set changeShowGif(bool value);

  set changeShowNSFW(bool value);

  void clearTags({List<String>? exceptTags}) {}

  void addTag({required String tag}) {}

  void deleteTag({required String tag}) {}
}

class AnimeTagsImpl implements IAnimeTags {
  List<String> _tags = [];
  bool _showGif = false;
  bool _showNSFW = true;

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
}
