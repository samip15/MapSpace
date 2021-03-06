import 'package:flutter/material.dart';
import 'package:map_space/provider/map_space.dart';
import 'package:map_space/screens/add_space_screen.dart';
import 'package:map_space/screens/space_detail_screen.dart';
import 'package:provider/provider.dart';

class SpaceListScreen extends StatelessWidget {
  static const String routeName = "/space_list_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Spaces"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, AddSpaceScreen.routeName);
              }),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<MapSpace>(context, listen: false).fetchAndSetSpaces(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<MapSpace>(
                  child: Center(
                    child: const Text("No spaces have been added yet!!"),
                  ),
                  builder: (ctx, mapSpace, ch) => mapSpace.spaces.length <= 0
                      ? ch
                      : ListView.builder(
                          itemCount: mapSpace.spaces.length,
                          itemBuilder: (ctx, index) => ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, SpaceDetailScreen.routeName,
                                  arguments: mapSpace.spaces[index].id);
                            },
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(mapSpace.spaces[index].image),
                            ),
                            title: Text(mapSpace.spaces[index].title),
                          ),
                        ),
                );
        },
      ),
    );
  }
}
