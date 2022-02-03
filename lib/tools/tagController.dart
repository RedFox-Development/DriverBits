import 'package:driver_bits/config.dart';
import 'package:driver_bits/utility_classes/tag.dart';

bool addTagToBox(Map<String,String> newTag) {
  List<Map<String,String>> tagsInBox = tagBox.get('default').toList().cast<Map<String,String>>();
  if (tagsInBox.isEmpty) {
    tagBox.put('default', [newTag]);
    return true;
  } else if (!tagsInBox.contains(newTag)) {
    List<Map<String, String>> tags = tagsInBox;
    tags.add(newTag);
    tagBox.put('default', tags);
    return true;
  } else {
    return false;
  }
}

List<Map<String,String>> getTagsInTheBox() {
  List<Map<String,String>> tagsInBox = tagBox.get('default')?.cast<Map<String,String>>();
  if (tagsInBox.isEmpty) {
    return [
      {'id':'fault-id', 'name':'fault', 'type':'indoor'}
    ];
  } else if (tagsInBox.isNotEmpty) {
    return tagsInBox;
  } else {
    return [
      {'id':'nope-id', 'name':'nope', 'type':'outdoor'}
    ];
  }
}