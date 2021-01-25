import 'package:flutter/material.dart';
import 'package:map_space/provider/map_space.dart';
import 'package:map_space/screens/map_screen.dart';
import 'package:provider/provider.dart';

class SpaceDetailScreen extends StatelessWidget {
  static const routeName = "/space_detail";
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final selectedSpace =
        Provider.of<MapSpace>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedSpace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedSpace.image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedSpace.location.address,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 18, color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => MapScreen(
                    isSelecting: false,
                    initialLocation: selectedSpace.location,
                  ),
                ),
              );
            },
            child: Text("View On Map"),
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
