import 'dart:convert';

import 'package:emoji_keybord/screens/emoji_keyboard/model/emojis.dart';

class LocalJsonParser {
  List<Emojis> parseJosn(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Emojis>((json) => new Emojis.fromJson(json)).toList();
  }
}
