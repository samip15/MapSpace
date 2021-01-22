import 'dart:io';

import 'package:flutter/material.dart';
import 'package:map_space/models/SpaceLocation.dart';

class MapSpace with ChangeNotifier {
  List<Space> _spaces = [];
  List<Space> get spaces {
    return [..._spaces];
  }

  void addSpace(String title, File imageFile) {
    final newSpace = Space(
        id: DateTime.now().toString(),
        title: title,
        location: null,
        image: imageFile);
    _spaces.add(newSpace);
    notifyListeners();
  }
}
