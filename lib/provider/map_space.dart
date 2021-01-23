import 'dart:io';

import 'package:flutter/material.dart';
import 'package:map_space/helper/db_helper.dart';
import 'package:map_space/models/SpaceLocation.dart';

class MapSpace with ChangeNotifier {
  List<Space> _spaces = [];
  List<Space> get spaces {
    return [..._spaces];
  }

  /// adding new space to our database
  void addSpace(String title, File imageFile) {
    final newSpace = Space(
        id: DateTime.now().toString(),
        title: title,
        location: null,
        image: imageFile);
    _spaces.add(newSpace);
    notifyListeners();
    // inserting to db
    DBHelper.insert("user_spaces", {
      'id': newSpace.id,
      'title': newSpace.title,
      'image': newSpace.image.path
    });
  }

  /// Fetching data and setting spaces
  Future<void> fetchAndSetSpaces() async {
    final dataList = await DBHelper.getData("user_spaces");
    _spaces = dataList
        .map(
          (item) => Space(
            id: item['id'],
            title: item['title'],
            location: null,
            image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
