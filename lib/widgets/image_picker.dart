import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:path/path.dart' as path;

class ImagePickerWidget extends StatefulWidget {
  final Function _onImagePicked;
  ImagePickerWidget(this._onImagePicked);

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickerWidget> {
  File _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if(pickedImage == null) {
      return;
    }

    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(pickedImage.path);
    _pickedImageFile = await pickedImage.copy('${appDir.path}/$fileName');
    widget._onImagePicked(_pickedImageFile);

    setState(() {
      _pickedImageFile = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _pickedImageFile == null
              ? Text(
                  'No Image Available !',
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _pickedImageFile,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.camera),
            label: Text('Take a picture'),
            textColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
