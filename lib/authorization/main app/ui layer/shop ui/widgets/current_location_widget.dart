import 'package:flutter/material.dart';
import 'package:mitrace/authorization/main%20app/business%20layer/shop%20bloc/select%20location%20bloc/location_bloc.dart';
import 'package:provider/provider.dart';

class CurrentLocationWidget extends StatefulWidget {
  const CurrentLocationWidget({Key? key}) : super(key: key);
  @override
  State<CurrentLocationWidget> createState() => _CurrentLocationWidgetState();
}

class _CurrentLocationWidgetState extends State<CurrentLocationWidget> {
  @override
  Widget build(BuildContext context) {
    LocationBloc blocObj = Provider.of<LocationBloc>(context);
    return StreamBuilder<String>(
      stream: blocObj.streamBlocModel,
      initialData: 'XIOAMI ONLINE STORE',
      builder: (context, AsyncSnapshot<String> snapshot) {
        return Text(
          '${snapshot.data}',
          style: const TextStyle(
            color: Colors.white,
          ),
        );
      },
    );
  }
}
