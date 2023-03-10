import '../helpers/objectAttribute.dart';
import 'account.dart';

class BankAccount {
  int? _isCA;
  String? _name;
  List<Account>? _accounts = [];


  BankAccount(this._isCA, this._name, this._accounts);

  BankAccount.map(dynamic obj) {
    _isCA = obj[ObjectAttribute.IS_CA];
    _name = obj[ObjectAttribute.NAME];
    for (var i = 0; i < obj[ObjectAttribute.ACCOUNTS].length; i++) {
      _accounts!.add(Account.map(obj[ObjectAttribute.ACCOUNTS][i]));
    }
    _accounts!.sort((a, b) => a.label!.toLowerCase().compareTo(b.label!.toLowerCase()));
  }

  List<Account>? get accounts => _accounts;

  String? get name => _name;

  int? get isCA => _isCA;
}
