import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_space/helper/location_helper.dart';
import 'package:map_space/screens/map_screen.dart';

class SpaceInput extends StatefulWidget {
  final Function saveLocation;
  const SpaceInput(this.saveLocation);
  @override
  _SpaceInputState createState() => _SpaceInputState();
}

class _SpaceInputState extends State<SpaceInput> {
  String _previewImageUrl;
  Future<void> _getUserLocation() async {
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
    _showPreview(locData.latitude, locData.longitude);
    widget.saveLocation(locData.latitude, locData.longitude);
  }

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl =
        LocationHelper.getLocationPreviewImage(latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text("No Location Choosen")
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (ctx, obj, trace) {
                    return Center(
                      child: Text("Sorry Api Error!!"),
                    );
                  },
                  loadingBuilder: (ctx, obj, trace) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _getUserLocation,
              icon: Icon(Icons.location_on),
              textColor: Theme.of(context).primaryColor,
              label: Text("Your Location"),
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              textColor: Theme.of(context).primaryColor,
              label: Text("Select On Map"),
            ),
          ],
        ),
      ],
    );
  }
}
