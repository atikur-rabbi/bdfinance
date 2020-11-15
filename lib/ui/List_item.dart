import 'package:flutter/material.dart';

class ListitemUi extends StatelessWidget {
  final String itemText;
  final Icon itemicon;
  final void Function() itemTap;
  

  const ListitemUi({
    Key key,
    @required this.itemText,
    this.itemicon,
    this.itemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: ValueKey(itemText),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(itemText),
          trailing: itemicon,
          onTap: itemTap,
        ),
      ),
    );
  }
}