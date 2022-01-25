
class Group {
  final String? _name;
  final String? _id;

  Group(String? id, String? name) : _name = name ?? 'default_group', _id = id ?? 'default';

  get name => _name;
  get id => _id;
  get details => {id: _id, name: _name};
}