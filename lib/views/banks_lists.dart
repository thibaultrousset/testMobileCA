import 'package:flutter/material.dart';
import 'package:test_mobile_ca/helpers/wording.dart';
import 'package:test_mobile_ca/widgets/bank_accounts_list_block.dart';

import '../models/bank_account.dart';

/// body of my account with the two lists of bank accounts

class BankList extends StatelessWidget {
  const BankList({Key? key, required this.bankAccountList}) : super(key: key);
 final List<BankAccount> bankAccountList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[300],
        title:
        Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: const Text(
                Wording.myAccounts,
                style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)
            )),
      ),
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) { return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            BankAccountListBlock(title: Wording.caBank,banks: bankAccountList.where((element) => element.isCA == 1).toList(),),
            BankAccountListBlock(title: Wording.otherBanks,banks: bankAccountList.where((element) => element.isCA == 0).toList(),),
          ],
        ),
      );}),

    );
  }

  void initState() {
    print("hrfdhdf");
    print(bankAccountList);
  }
}
