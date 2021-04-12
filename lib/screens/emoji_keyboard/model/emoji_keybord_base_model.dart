import 'dart:convert';

import 'package:emoji_keybord/Utility/SharedPool.dart';
import 'package:emoji_keybord/constants.dart';

import 'package:emoji_keybord/screens/emoji_keyboard/utility/local_json_parser.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'emojis.dart';

class EmojiKeyboardBaseModel extends ChangeNotifier {
  final BuildContext context;
  SharedPool sharedPool = SharedPool();
  bool searching = false;
  List<Emojis> emojis;
  List<Emojis> selectedEmojis = [];
  List<Emojis> searchEmojis = [];
  int selectedTabIndex = 0;
  List<Emojis> usedEmojis = [];
  String selectedCat = cat_recent;
  String enteredText;

//List for tab Emoji Keyboard header.
  List<Map<String, dynamic>> keybortTab = [
    {"emoji": "⌚", "category": cat_recent},
    {"emoji": "🙂", "category": cat_smileys},
    {"emoji": "🤟", "category": cat_people},
    {"emoji": "🍀", "category": cat_animals},
    {"emoji": "🍔", "category": cat_food},
    {"emoji": "✈️", "category": cat_travel},
    {"emoji": "🏉", "category": cat_activities},
    {"emoji": "💎", "category": cat_objects},
    {"emoji": "🔄", "category": cat_symbols},
    {"emoji": "🏳️", "category": cat_flags}
  ];

  //Json Parser conver String to ListofObjects
  LocalJsonParser localJsonParser = LocalJsonParser();

  EmojiKeyboardBaseModel(this.context) {
    loadJson();
  }


//Load json from emoji.json and Get frequently used Emojis from sharedprefrances
  void loadJson() async {
    SharedPool.getRecent().then((value) {
      print(value);
      usedEmojis = localJsonParser.parseJosn(value);
    });
    String data = await rootBundle.loadString('assets/json/emoji.json');
    print(data);
    emojis = localJsonParser.parseJosn(data);
    filterByType();
   }

//On select Category from  tab of emoji category 
  void selectingEmojiCat(int index) {
    searching = false;
    selectedCat = keybortTab[index]["category"];
    if (selectedCat == cat_recent) {
      List<Emojis> reversedList = new List.from(usedEmojis.reversed);
      usedEmojis = reversedList;
    }
    filterByType();
    notifyListeners();
  }

  // filter emojis category from json accoding to selected category
  void filterByType() {
    selectedEmojis.clear();
    for (Emojis emoji in emojis) {
      if (emoji.category == selectedCat) {
        selectedEmojis.add(emoji);
      }
    }
    notifyListeners();
  }

 // 
  void isSearching() {
    searching = true;
    notifyListeners();
  }

  void textInputChange(String text) {
    print("Inside onChanhged");
    enteredText = text;
// Update searchEmojis list acording to serch text
// its check first TAG and then check description.
    searchEmojis = emojis 
        .where((emoji) => emoji.tags.contains(text.toLowerCase())
            )
        .toList();
    if (searchEmojis.isEmpty) {
      searchEmojis = emojis
          .where(
            (emoji) =>
                emoji.description.toLowerCase().contains(
                      text.toLowerCase(),
                    ),
          )
          .toList();
    }

    notifyListeners();
  }

//Whecn Select EMoji from keyboard.
  onClickEmoji(int index) {
    notifyListeners();

    //check usedEmojis is empty or not if is empty then add without any check.

    if (usedEmojis.isEmpty) {
      searching
          ? usedEmojis.add(searchEmojis[index])
          : usedEmojis.add(selectedEmojis[index]);
      return;
    } else {
      if (!checkIsExists(index)) {
        //check lenght is >=45 then remove last item
        if (usedEmojis.length >= 45) {
          usedEmojis.removeLast();
        }
        searching
            ? usedEmojis.add(searchEmojis[index])
            : usedEmojis.add(selectedEmojis[index]);
        String usedEmojisStr = jsonEncode(usedEmojis);
        SharedPool.saveRecent(usedEmojisStr);
      }
    }
  }
//check selected emoji is already exists in usedEmojis
  bool checkIsExists(int index) {
    bool isExists = false;
    String description = searching
        ? searchEmojis[index].description
        : selectedEmojis[index].description;
    for (Emojis emoji in usedEmojis) {
      if (emoji.description == description) {
        isExists = true;
      }
    }
    return isExists;
  }
}
