import '../helpers/object_attribute.dart';
import 'account.dart';

class BankAccount {
  int _isCA = 0;
  String _name = "";
  List<Account> _accounts = [];

  BankAccount(this._isCA, this._name, this._accounts);

  BankAccount.map(dynamic obj) {
    _isCA = obj[ObjectAttribute.isCA]??0;
    _name = obj[ObjectAttribute.name]??"";
    for (var a in  obj[ObjectAttribute.accounts]?? []) {
      _accounts.add(Account.map(a));
    }
    _accounts.sort((a, b) => a.label.toLowerCase().compareTo(b.label.toLowerCase()));
  }

  List<Account> get accounts => _accounts;

  String get name => _name;

  int get isCA => _isCA;
}
