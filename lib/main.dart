import 'package:emoji_keybord/screens/emoji_keyboard/emoji_keyboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emoji Keybord',
      home: EmojiKeyboard(),
    );
  }
}
