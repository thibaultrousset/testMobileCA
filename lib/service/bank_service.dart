import 'package:test_mobile_ca/views/banks_lists.dart';

import '../helpers/http.dart';
import '../models/bank_account.dart';
import '../utils/api.dart';

/// service with methods about authentication

class BankService {
  final Api _api = Api.instance;

  ///  Send email & password and get a user's token if credentials are correct
  Future<List<BankAccount>> getBanks() {
    return _api.request(Http.GET, "banks.json", needAuthentication: false).then((dynamic res) {
      List<BankAccount> mappedBankList = [];
      for (var i=0; i<res.length; i++){
          mappedBankList.add(BankAccount.map(res[i]));
      }
      mappedBankList.sort((a,b) => a.name.compareTo(b.name));
      return mappedBankList;
    });
  }


}
