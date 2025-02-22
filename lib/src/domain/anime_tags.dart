abstract class IAnimeTags {
  List<String> get tags;

  set changeAllTagsTo(List<String> value);

  void clearTags({List<String>? exceptTags}) {}

  void addTag({required String tag}) {}

  void deleteTag({required String tag}) {}
}

class AnimeTagsImpl implements IAnimeTags {
  List<String> _tags = [];

  @override
  List<String> get tags => _tags;

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
}
