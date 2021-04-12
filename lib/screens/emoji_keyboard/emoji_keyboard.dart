import 'package:emoji_keybord/screens/emoji_keyboard/components/keyboard.dart';
import 'package:emoji_keybord/screens/emoji_keyboard/model/emoji_keybord_base_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmojiKeyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EmojiKeyboardBaseModel>(
      create: (context) => EmojiKeyboardBaseModel(context),
      lazy: false,
      child: Consumer<EmojiKeyboardBaseModel>(
        builder: (context, snapshot, child) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    color: Colors.black87,
                    child: keyBoard(snapshot),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
