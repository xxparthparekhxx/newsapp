import 'package:flutter/material.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:provider/provider.dart';

class DrawerItem extends StatelessWidget {
  final IconData iconData;
  final String text;
  final bool selected;
  final int index;

  const DrawerItem(
      {Key? key,
      required this.iconData,
      required this.text,
      required this.selected,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: ListTile(
        leading: Icon(
          iconData,
        ),
        title: Text(text),
        selected: selected,
        selectedColor: Colors.black,
        selectedTileColor: Colors.amber.shade200,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
        )),
        onTap: () => {
          Provider.of<NP>(context, listen: false).setindex(index),
          Navigator.pop(context)
        },
      ),
    );
  }
}
