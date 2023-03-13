import 'package:flutter/material.dart';
import 'package:test_mobile_ca/service/bank_service.dart';
import 'package:test_mobile_ca/utils/snack_bar.dart';
import 'package:test_mobile_ca/views/banks_lists.dart';

import '../helpers/wording.dart';
import '../models/bank_account.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<BankAccount> bankAccountList = [];

  BankService bankService = BankService();
  SnackBarUtil snackBarUtil = SnackBarUtil();


  /// get bank list with api request
  getBanks(){
    bankService.getBanks().then((res) {
      setState(() {
        bankAccountList = res;
      });
    }).catchError((error) {
      snackBarUtil.displayMessage(error.toString(), scaffoldKey, context);
    });
  }

  @override
  void initState() {
    super.initState();
    getBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // keep bottom nav bar during navigation
      body: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (_) => BankList(bankAccountList: bankAccountList));
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