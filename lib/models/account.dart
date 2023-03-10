import 'package:test_mobile_ca/models/operation.dart';

import '../helpers/objectAttribute.dart';

class Account {
  String? _id;
  double? _balance;
  String? _contractNumber;
  String? _holder;
  String? _label;
  List<Operation>? _operations = [];
  int? _order;
  String? _productCode;
  int? _role;


  Account(this._id, this._balance, this._contractNumber, this._holder, this._label, this._operations, this._order, this._productCode, this._role);

  Account.map(dynamic obj) {
    _id = obj[ObjectAttribute.ID];
    _balance = obj[ObjectAttribute.BALLANCE];
    _contractNumber = obj[ObjectAttribute.CONTRACT_NUMBER];
    _holder = obj[ObjectAttribute.HOLDER];
    _label = obj[ObjectAttribute.LABEL];
    for (var i = 0; i < obj[ObjectAttribute.OPERATIONS].length; i++) {
      _operations!.add(Operation.map(obj[ObjectAttribute.OPERATIONS][i]));
    }
    _operations!.sort((a, b) => a.title!.toLowerCase().compareTo(b.title!.toLowerCase()));
    _operations!.sort((a, b) => a.date!.toLowerCase().compareTo(b.date!.toLowerCase()));
    _order = obj[ObjectAttribute.ORDER];
    _productCode = obj[ObjectAttribute.PRODUCT_CODE];
    _role = obj[ObjectAttribute.ROLE];
  }

  List<Operation>? get operations => _operations;

  String? get label => _label;

  String? get holder => _holder;

  String? get contractNumber => _contractNumber;

  double? get balance => _balance;

  String? get id => _id;

  int? get role => _role;

  String? get productCode => _productCode;

  int? get order => _order;
}
