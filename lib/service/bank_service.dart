import 'package:test_mobile_ca/helpers/api_routes.dart';

import '../helpers/http.dart';
import '../models/bank_account.dart';
import '../utils/api.dart';

/// service with methods about banks

class BankService {
  final Api _api = Api.instance;

  // get list of banks
  Future<List<BankAccount>> getBanks() {
    return _api.request(Http.get, ApiRoutes.bankList, needAuthentication: false).then((dynamic res) {
      List<BankAccount> mappedBankList = [];
      for (var i=0; i<res.length; i++){
        mappedBankList.add(BankAccount.map(res[i]));
      }
      // order banks alphabetically
      mappedBankList.sort((a,b) => a.name.compareTo(b.name));
      return mappedBankList;
    });
  }
}
