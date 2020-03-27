import 'package:flutter/material.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () {},),
        ],
      ),
      body: Center(child: CircularProgressIndicator()),
    
    );
  }
}
