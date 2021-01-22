import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class ImageInput extends StatefulWidget {
  final Function saveImage;

  ImageInput(this.saveImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _galleryFile;
  final _imagePicker = new ImagePicker();

  /// open image piker
  Future<void> _chooseGallery() async {
    final image = await _imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _galleryFile = File(image.path);
    });
    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final saveImageFile = await _galleryFile.copy('${appDir.path}/$fileName');
    widget.saveImage(saveImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 150,
          width: 140,
          child: _galleryFile == null
              ? Text("No Image Taken")
              : Image.file(
                  _galleryFile,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            onPressed: _chooseGallery,
            icon: Icon(Icons.file_copy),
            label: Text(
              "Choose From gallery",
            ),
          ),
        ),
      ],
    );
  }
}
