import 'package:emoji_keybord/constants.dart';
import 'package:emoji_keybord/screens/emoji_keyboard/model/emoji_keybord_base_model.dart';
import 'package:flutter/material.dart';

Container serchBox(EmojiKeyboardBaseModel snapshot) {
  return Container(
    padding: const EdgeInsets.all(kDefaultPadding * 0.2),
    height: 45,
    child: TextField(
      cursorColor: Colors.blue.shade800,
      style: TextStyle(color: Colors.blue.shade800),
      decoration: InputDecoration(
        fillColor: Color(0xFFEBEBEB),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue.shade800,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFEBEBEB), width: 1.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFEBEBEB), width: 1.0),
        ),
        hintText: serchtext,
        hintStyle: TextStyle(
            letterSpacing: 0.4,
            fontFamily: "HelveticaNeueMedium",
            fontSize: 14,
            color: Colors.blue.shade800),
        prefixIcon: Icon(
          Icons.search,
          size: 20,
          color: Colors.blue,
        ),
      ),
      onTap: () {
        snapshot.isSearching();
      },
      onChanged: (text) {
        snapshot.textInputChange(text);
      },
    ),
  );
}
