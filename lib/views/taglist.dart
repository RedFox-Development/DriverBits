import 'package:flutter/material.dart';
import 'package:driver_bits/utility_classes/tag.dart';
import 'package:driver_bits/views/tag_ui.dart';
import 'package:driver_bits/utility_classes/group.dart';

class TagList extends StatefulWidget {
  const TagList({Key? key}) : super(key: key);

  @override
  State<TagList> createState() => _TagList();
}

class _TagList extends State<TagList> {
  int _currentTagIndex = -1;
  late List<Tag> _tags;

  @override
  initState() {
    super.initState();
    _tags = [Tag('default-id', 'default', 'indoor')];
    _currentTagIndex = 0;
  }

  void _selectTag(int indexOf) => setState(() {
    _currentTagIndex = indexOf;
  });

  @override
  Widget build(BuildContext context) {

    Widget _currentTag() {
      return Center(
        child: TagUi(tag: _tags[_currentTagIndex]),
      );
    }

    Widget _noTag() => Center(
      child: Text(
        'No tags were found',
        style: Theme.of(context).textTheme.headline4,
      ),
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: _currentTagIndex < 0 ? _noTag() : _currentTag(),
    );
  }
}