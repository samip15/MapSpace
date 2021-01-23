import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:map_space/helper/location_helper.dart';

class SpaceInput extends StatefulWidget {
  @override
  _SpaceInputState createState() => _SpaceInputState();
}

class _SpaceInputState extends State<SpaceInput> {
  String _previewImageUrl;
  Future<void> _getUserLocation() async {
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
    final staticMapImageUrl = LocationHelper.getLocationPreviewImage(
        latitude: locData.latitude, longitude: locData.longitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
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
              onPressed: () {},
              icon: Icon(Icons.location_on),
              textColor: Theme.of(context).primaryColor,
              label: Text("Select On Map"),
            ),
          ],
        ),
      ],
    );
  }
}
