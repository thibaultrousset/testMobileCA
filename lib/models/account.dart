import 'package:test_mobile_ca/models/operation.dart';

import '../helpers/object_attribute.dart';

class Account {
  String? _id;
  double _balance = 0.0;
  String _contractNumber = "";
  String _holder = "";
  String _label = "";
  List<Operation> _operations = [];
  int _order = 0;
  String _productCode = "";
  int _role = 0;

  Account(this._id, this._balance, this._contractNumber, this._holder, this._label, this._operations, this._order, this._productCode, this._role);

  Account.map(dynamic obj) {
    _id = obj[ObjectAttribute.id];
    _balance = obj[ObjectAttribute.balance];
    _contractNumber = obj[ObjectAttribute.contractNumber];
    _holder = obj[ObjectAttribute.holder];
    _label = obj[ObjectAttribute.label];
    for (var o in obj[ObjectAttribute.operations]?? []) {
      _operations.add(Operation.map(o));
    }
    // first sort alphabetically
    // then sort by date newest first
    // this way if two have the same date tey will be ordered alphabetically
    _operations.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    _operations.sort((b, a) => a.date.toLowerCase().compareTo(b.date.toLowerCase()));

    _order = obj[ObjectAttribute.order];
    _productCode = obj[ObjectAttribute.productCode];
    _role = obj[ObjectAttribute.role];
  }

  List<Operation> get operations => _operations;

  String get label => _label;

  String get holder => _holder;

  String get contractNumber => _contractNumber;

  double get balance => _balance;

  String? get id => _id;

  int get role => _role;

  String get productCode => _productCode;

  int get order => _order;
}
