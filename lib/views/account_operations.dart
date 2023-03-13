import 'package:flutter/material.dart';
import 'package:test_mobile_ca/helpers/global.dart';
import 'package:test_mobile_ca/helpers/wording.dart';
import 'package:test_mobile_ca/models/account.dart';

import '../widgets/empty_state.dart';

/// body of detail of an account with list of operations

class AccountOperations extends StatelessWidget {
  const AccountOperations({Key? key, required this.account}) : super(key: key);
  final Account account;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: MediaQuery.of(context).size.width,
        leading: TextButton.icon(
          icon:  const Icon(
            Icons.arrow_back_ios,
            color: Colors.blueAccent,),
          onPressed: () {  Navigator.of(context).pop(); },
          label: Container(
            alignment: Alignment.centerLeft,
            child: const Text(Wording.myAccounts,style: TextStyle(color: Colors.blueAccent,fontSize: 20),),),
        ),
        backgroundColor: Colors.grey[300],
        bottom: PreferredSize(
            preferredSize:  Size(MediaQuery.of(context).size.width - 40, 150.0),
            child:  SizedBox(
              height: 150,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 5),
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: Text(
                          "${account.balance} €",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 40,
                              fontWeight: FontWeight.bold) )),
                  Container(
                      margin: const EdgeInsets.only(left: 5),
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: Text(
                          account.label,
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 25,
                              fontWeight: FontWeight.bold) ))
                ],),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              account.operations.isNotEmpty ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: account.operations.length,
                  itemBuilder: (BuildContext context, int index) {
                    //map List of our data to the ListView
                    return ListTile(
                      title:Text(
                          account.operations[index].title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)
                      ),
                      subtitle: Text(
                        // format unix time stamp to dd/MM/yyyy
                          Global.inputFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(account.operations[index].date)*1000)).toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          )
                      ),
                      trailing: Text(
                          "${account.operations[index].amount} €",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          )
                      ),
                    );
                  }) : const EmptyState(message:Wording.emptyOperations,)
            ]
        ),
      ),
    );
  }

  void initState() {}
}
