import 'dart:io';

import 'package:flutter/material.dart';

class ImagePicker extends StatefulWidget {
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  File _imageUrl;
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
          child: _imageUrl == null
              ? Text(
                  'No Image Available !',
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _imageUrl,
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
            onPressed: () {},
            icon: Icon(Icons.camera),
            label: Text('Take a picture'),
            textColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
