import 'package:flutter/material.dart';
import 'package:xyz/screens/auth/register_screen.dart';

import '../widgets/connection_check.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConnectionCheck(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Welcome to XYZ app',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24)),
                    ),
                    Text('Please login to your account or create'),
                    Text('new account to contniue'),
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => const LoginScreen()));
                      },
                      child: const Text('LOGIN'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => const RegisterScreen()));
                      },
                      child: const Text('CREATE ACCOUNT'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
