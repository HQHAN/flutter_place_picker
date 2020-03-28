import 'package:flutter/material.dart';
import 'package:place_picker/providers/greate_place_provider.dart';
import 'package:provider/provider.dart';
import 'add_place_screen.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaceProvider>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaceProvider>(
                child: Center(
                  child: const Text('Got no places yet! start adding some!'),
                ),
                builder: (ctx, placeProvider, ch) =>
                    placeProvider.items.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: placeProvider.items.length,
                            itemBuilder: (ctx, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(placeProvider.items[index].image),
                              ),
                              title: Text(placeProvider.items[index].title),
                            ),
                          ),
              ),
      ),
    );
  }
}
