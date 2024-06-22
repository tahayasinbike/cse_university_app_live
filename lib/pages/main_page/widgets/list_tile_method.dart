import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
ListTile ListTileMethod(
    {required BuildContext context, required String titlee, Widget? sayfa, String? subTitlee,  IconData? icon}) {
  return ListTile(
    dense: true,
    leading:icon != null 
    ? Icon(
      icon,
      color: Theme.of(context).iconTheme.color,
    )
    :SizedBox.shrink(),
    title: Text(
      titlee,
      style: TextStyle(
            fontSize: 17,
            color: Color(0xffa5d7e8),
            shadows: [BoxShadow(color: Colors.black, blurRadius: 10, offset: Offset(0, 1), spreadRadius: 5)]),
    ),
    subtitle: subTitlee != null
        ? Text(
            subTitlee,
            style: const TextStyle(color: Colors.red, fontSize: 13),
          )
        : null,
    onTap: () {
      sayfa != null
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => sayfa,
              ))
          : null;
    },
  );
}
