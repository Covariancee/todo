import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectionCheck extends StatelessWidget {
  const ConnectionCheck({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, connectivitySnapshot) {
          var connectivityResult = connectivitySnapshot.data;
          var hasConnectivity = connectivityResult != ConnectivityResult.none;

          if (!hasConnectivity) {
            return const Scaffold(
              body: Center(
                child: Text('Check your connection!'),
              ),
            );
          }
          return child;
        });
  }
}
