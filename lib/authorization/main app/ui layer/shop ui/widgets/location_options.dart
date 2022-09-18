import 'package:flutter/material.dart';
import 'package:mitrace/authorization/main%20app/business%20layer/shop%20bloc/select%20location%20bloc/location_bloc.dart';
import 'package:provider/provider.dart';

class LocationOptions extends StatefulWidget {
  const LocationOptions({Key? key}) : super(key: key);
  @override
  State<LocationOptions> createState() => _LocationOptionsState();
}

class _LocationOptionsState extends State<LocationOptions> {
  showDialogToSelectLocation() {
    LocationBloc blocObj = Provider.of<LocationBloc>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Select Store Location'),
          children: [
            TextButton(
              child: const Text('Bangalore'),
              onPressed: () {
                blocObj.updateWith(location: 'Bangalore');
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Mumbai'),
              onPressed: () {
                blocObj.updateWith(location: 'Mumbai');
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Vizag'),
              onPressed: () {
                blocObj.updateWith(location: 'Vizag');
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Jaipur'),
              onPressed: () {
                blocObj.updateWith(location: 'Jaipur');
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Chennai'),
              onPressed: () {
                blocObj.updateWith(location: 'Chennai');
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('us'),
              onPressed: () {
                blocObj.updateWith(location: 'us');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.location_on_sharp,
        color: Colors.white,
      ),
      onPressed: () {
        showDialogToSelectLocation();
      },
    );
  }
}
