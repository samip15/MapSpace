import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// location
class SpaceLocation {
  final double latitude;
  final double longitude;
  final String address;
  const SpaceLocation(
      {@required this.latitude, @required this.longitude, this.address});
}

// place
class Space {
  final String id;
  final String title;
  final SpaceLocation location;
  final File image;

  Space(
      {@required this.id,
      @required this.title,
      @required this.location,
      @required this.image});
}
