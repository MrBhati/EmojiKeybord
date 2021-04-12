import 'package:emoji_keybord/constants.dart';
import 'package:emoji_keybord/screens/emoji_keyboard/components/search_box.dart';
import 'package:emoji_keybord/screens/emoji_keyboard/model/emoji_keybord_base_model.dart';
import 'package:flutter/material.dart';

Padding keyBoard(EmojiKeyboardBaseModel snapshot) {
  return Padding(
    padding: const EdgeInsets.all(kDefaultPadding * 0.5),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding * 0.2),
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.keybortTab.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    snapshot.selectingEmojiCat(index);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 0.3),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 32,
                          child: Center(
                            child: Text(
                              snapshot.keybortTab[index]["emoji"],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        snapshot.selectedCat ==
                                snapshot.keybortTab[index]["category"]
                            ? Container(
                                height: 2,
                                color: Colors.indigo,
                                width: 28,
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                );
              }),
        ),
        serchBox(snapshot),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  kDefaultPadding * 0.5,
                ),
                child: Text(
                  snapshot.searching
                      ? "Searched Results"
                      : snapshot.selectedCat,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: snapshot.selectedCat == cat_recent
                      ? snapshot.searching
                          ? snapshot.searchEmojis.length
                          : snapshot.usedEmojis.length
                      : snapshot.searching
                          ? snapshot.searchEmojis.length
                          : snapshot.selectedEmojis.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7),
                  itemBuilder: (BuildContext context, int index) {
                    return buildEmojiBody(snapshot, index);
                    // return SizedBox(
                    //   height: 40,
                    //   width: 40,
                    //   child: Container(
                    //     //color: Colors.pink.shade300,
                    //     child: Center(
                    //       child: GestureDetector(
                    //         onTap: () {
                    //           print("CLICKED");
                    //           snapshot.onClickEmoji(index);
                    //         },
                    //         child: Text(
                    //           snapshot.selectedCat == "recent emoji"
                    //               ? snapshot.usedEmojis[index].emoji
                    //               : snapshot.searching
                    //                   ? snapshot.searchEmojis[index].emoji
                    //                   : snapshot.selectedEmojis[index].emoji,
                    //           style: TextStyle(fontSize: 24),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildEmojiBody(EmojiKeyboardBaseModel snapshot, int index) {
  return SizedBox(
    height: 40,
    width: 40,
    child: Container(
      //color: Colors.pink.shade300,
      child: Center(
        child: GestureDetector(
          onTap: () {
            print("CLICKED");
            snapshot.onClickEmoji(index);
          },
          child: Text(
            snapshot.selectedCat == cat_recent
                ? snapshot.searching
                    ? snapshot.searchEmojis[index].emoji
                    : snapshot.usedEmojis[index].emoji
                : snapshot.searching
                    ? snapshot.searchEmojis[index].emoji
                    : snapshot.selectedEmojis[index].emoji,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    ),
  );
}
