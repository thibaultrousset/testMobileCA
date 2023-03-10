import '../helpers/object_attribute.dart';
import 'account.dart';

class BankAccount {
  int? _isCA;
  String? _name;
  List<Account>? _accounts = [];


  BankAccount(this._isCA, this._name, this._accounts);

  BankAccount.map(dynamic obj) {
    _isCA = obj[ObjectAttribute.isCA];
    _name = obj[ObjectAttribute.name];
    for (var i = 0; i < obj[ObjectAttribute.accounts].length; i++) {
      _accounts!.add(Account.map(obj[ObjectAttribute.accounts][i]));
    }
    _accounts!.sort((a, b) => a.label!.toLowerCase().compareTo(b.label!.toLowerCase()));
  }

  List<Account>? get accounts => _accounts;

  String? get name => _name;

  int? get isCA => _isCA;
}
