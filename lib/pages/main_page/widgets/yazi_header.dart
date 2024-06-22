import 'package:flutter/material.dart';

Padding yaziHeader(String text, context) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, bottom: 15, top: 15),
    child: Align(alignment: Alignment.bottomLeft, child: Text(text, style: Theme.of(context).textTheme.displayLarge)),
  );
}
