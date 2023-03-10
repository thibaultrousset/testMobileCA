import 'package:flutter/material.dart';
import 'package:test_mobile_ca/views/account_operations.dart';
import 'package:test_mobile_ca/views/banks_lists.dart';

import '../helpers/response_json.dart';
import '../helpers/wording.dart';
import '../models/bank_account.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BankAccount>? caBankAccountList = [];
  List<BankAccount>? otherBankAccountList = [];

  // create list of bank accounts mapped with models and separates in 2 lists
  // CA bank accounts ans other bank accounts
  generateBankAccountList(bankAccounts){
    // loop on api response (json here)
    for (var i=0; i<bankAccounts.length; i++){
      // map on model
      var bankAccountTemp = BankAccount.map(bankAccounts[i]);
      // separate ca from others
      if(bankAccountTemp.isCA == 0){
        caBankAccountList!.add(bankAccountTemp);
      }
      else {
        otherBankAccountList!.add(bankAccountTemp);
      }
    }
    // sort alphabetically order by names
    caBankAccountList!.sort((a, b) => a.name!.compareTo(b.name!));
    otherBankAccountList!.sort((a, b) => a.name!.compareTo(b.name!));
  }

  @override
  void initState() {
    super.initState();
    generateBankAccountList(responseJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // keep bottom nav bar during navigation
      body: Navigator(
        onGenerateRoute: (settings) {
          Widget page =  BanksList(caBankAccountList: caBankAccountList,otherBankAccountList: otherBankAccountList,);
          if (settings.name == 'page2') page = const AccountOperations();
          return MaterialPageRoute(builder: (_) => page);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            activeIcon: Container(
                padding: const EdgeInsets.only(bottom: 5, top: 10),
                child: const Icon(
                  Icons.star,
                  color: Colors.blueAccent,
                  size: 30,
                )),
            icon: Container(
                padding: const EdgeInsets.only(bottom: 5, top: 10),
                child: const Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 30,
                )),
            label: Wording.myAccounts,
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
                padding: const EdgeInsets.only(bottom: 5, top: 10),
                child: const Icon(
                  Icons.star,
                  color: Colors.blueAccent,
                  size: 30,
                )),
            icon: Container(
                padding: const EdgeInsets.only(bottom: 5, top: 10),
                child: const Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 30,
                )),
            label: Wording.simulation,
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
                padding: const EdgeInsets.only(bottom: 5, top: 10),
                child: const Icon(
                  Icons.star,
                  color: Colors.blueAccent,
                  size: 30,
                )),
            icon: Container(
                padding: const EdgeInsets.only(bottom: 5, top: 10),
                child: const Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 30,
                )),
            label: Wording.yourTurnToPlay,
          )
        ],
        currentIndex: 0,
      ),
    );
  }
}