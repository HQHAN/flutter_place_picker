import 'dart:io';

import 'package:flutter/material.dart';
import 'package:place_picker/providers/greate_place_provider.dart';
import 'package:place_picker/widgets/image_picker.dart';
import 'package:place_picker/widgets/location_picker.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> with WidgetsBindingObserver {
  final _titleTextController = TextEditingController();
  File _imageFileToSave;

  void _onSelectImage(File pickedImage) {
    _imageFileToSave = pickedImage;
  }

  void _onAddPlace() {
    if (_titleTextController.value == null || _imageFileToSave == null) {
      return;
    }

    Provider.of<GreatPlaceProvider>(context, listen: false).savePlace(
      _titleTextController.text,
      _imageFileToSave,
    );

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    _titleTextController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    print('AddScreen dispose() called');
  }

  // A TextField must lose focus when the app pauses.
  // Otherwise it loses text when the app resumes again,
  // e.g. when switching to "Recent Apps" and back.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleTextController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImagePickerWidget(_onSelectImage),
                    SizedBox(height: 10,),
                    LocationPickerWidget(),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _onAddPlace,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            color: Theme.of(context).accentColor,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
