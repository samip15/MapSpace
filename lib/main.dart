import 'package:flutter/material.dart';
import 'package:map_space/provider/map_space.dart';
import 'package:map_space/screens/add_space_screen.dart';
import 'package:map_space/screens/space_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return MapSpace();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green,
          accentColor: Colors.brown,
        ),
        home: SpaceListScreen(),
        routes: {
          SpaceListScreen.routeName: (ctx) => SpaceListScreen(),
          AddSpaceScreen.routeName: (ctx) => AddSpaceScreen(),
        },
      ),
    );
  }
}
