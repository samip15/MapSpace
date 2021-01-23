import 'dart:io';

import 'package:flutter/material.dart';
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
  File _imageFile;

  void _saveSpace() {
    if (_titleController.text.isEmpty || _imageFile == null) {
      return;
    }
    Provider.of<MapSpace>(context, listen: false)
        .addSpace(_titleController.text, _imageFile);
    Navigator.of(context).pop();
  }

  void _selectedImage(File getImage) {
    _imageFile = getImage;
  }

  @override
  void dispose() {
    _titleController.dispose();
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
                  ImageInput(_selectedImage),
                  SizedBox(
                    height: 10,
                  ),
                  SpaceInput(),
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
