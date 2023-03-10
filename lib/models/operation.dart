import '../helpers/object_attribute.dart';

class Operation {
  String? _id;
  String? _amount;
  String? _category;
  String? _date;
  String? _title;

  Operation(this._id, this._amount, this._category, this._date, this._title);

  Operation.map(dynamic obj) {
    _id = obj[ObjectAttribute.id];
    _amount = obj[ObjectAttribute.amount];
    _category = obj[ObjectAttribute.category];
    _date = obj[ObjectAttribute.date];
    _title = obj[ObjectAttribute.title];
  }

  String? get title => _title;

  String? get date => _date;

  String? get category => _category;

  String? get amount => _amount;

  String? get id => _id;
}
