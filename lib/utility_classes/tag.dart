
class Tag {
  final String _id;
  final String _name;
  final String _type;

  Tag(String id, String name, String type) : _id = id, _name = name, _type = type;

  get id => _id;
  get name => _name;
  get type => _type;
}