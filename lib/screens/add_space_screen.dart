import 'dart:io';

import 'package:flutter/material.dart';
import 'package:map_space/models/SpaceLocation.dart';
import 'package:map_space/provider/map_space.dart';
import 'package:map_space/widgets/image_input.dart';
import 'package:map_space/widgets/space_input.dart';
import 'package:provider/provider.dart';

class AddSpaceScreen extends StatefulWidget {
  static const String routeName = "/add_space_screen";

  @override
  _AddSpaceScreenState createState() => _AddSpaceScreenState();
}

class _AddSpaceScreenState extends State<AddSpaceScreen> {
  TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressContorller = TextEditingController();
  File _imageFile;
  SpaceLocation _pickedLocation;

  void _saveSpace() {
    if (_titleController.text.isEmpty ||
        _addressContorller.text.isEmpty ||
        _imageFile == null) {
      return;
    }
    final finalLocation = SpaceLocation(
        latitude: _pickedLocation?.latitude,
        longitude: _pickedLocation?.longitude,
        address: _addressContorller.text);
    Provider.of<MapSpace>(context, listen: false)
        .addSpace(_titleController.text, _imageFile, finalLocation);
    Navigator.of(context).pop();
  }

  void _selectedImage(File getImage) {
    _imageFile = getImage;
  }

  void _saveLocation(double lat, double lng) {
    _pickedLocation = SpaceLocation(latitude: lat, longitude: lng);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _addressContorller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Spaces"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: "Title",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _addressContorller,
                    decoration: InputDecoration(labelText: "Enter The Address"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ImageInput(_selectedImage),
                  SizedBox(
                    height: 10,
                  ),
                  SpaceInput(_saveLocation),
                ],
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _saveSpace,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            icon: Icon(Icons.save),
            label: Text("Save"),
            textColor: Colors.white,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
