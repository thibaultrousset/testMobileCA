import 'package:flutter/material.dart';

/// screen to display when no data to show
/// custom message depending on screen

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key, this.message}) : super(key: key);
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(10),
              child: Text(message!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black,  fontWeight: FontWeight.w700)))
        ]));
  }

  void initState() {}
}
