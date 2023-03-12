import 'package:flutter/material.dart';
import 'package:test_mobile_ca/models/bank_account.dart';
import 'package:test_mobile_ca/views/account_operations.dart';

/// reusable widget to display a list of bank accounts

class BankAccountListBlock extends StatelessWidget {
  const BankAccountListBlock({Key? key, required this.title, required this.banks}) : super(key: key);
  final String title;
  final List<BankAccount> banks;

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(left: 5),
              padding: const EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontWeight: FontWeight.bold) )),
          banks.isNotEmpty ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: banks?.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                  title:Text(
                      banks?[index].name??"",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)
                  ),
                  children: [
                    ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: banks![index].accounts.length,
                    itemBuilder: (BuildContext context, int index2) {
                      //map List of our data to the ListView
                      return Container(
                          padding:const EdgeInsets.only(left: 8),
                          child: ListTile(
                            title:Text(
                                banks?[index].accounts[index2].label??"",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                            ),
                            trailing:Text(
                                "${banks?[index].accounts[index2].balance} €",
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>  AccountOperations(account: banks![index].accounts[index2]),
                                ),
                              );
                            }
                            ));
                    })],);
              }): Container(child: Text("Aucune banque"),)
        ]
    );
  }

  void initState() {
    print("here");
  }
}
