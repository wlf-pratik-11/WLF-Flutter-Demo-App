import 'dart:ui';

import 'package:flutter/material.dart';

TextStyle appbarTextStyle() {
  return TextStyle(
    color: Colors.white,
  );
}

ListView drawerItem(List lstItem) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: lstItem.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(
          lstItem[index]["name"],
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => lstItem[index]["route"]));
        },
      );
    },
  );
}
