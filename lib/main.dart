import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xyz/provider/auth_provider.dart';
import 'package:xyz/provider/home_screen_provider.dart';
import 'package:xyz/screens/auth/login_screen.dart';
import 'package:xyz/screens/auth/splash_screen.dart';
import 'package:xyz/screens/home_screen.dart';

import 'firebase_options.dart';
import 'provider/add_task_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ListenableProvider<AuthProvider>(create: (_) => AuthProvider()),
      ListenableProvider<AddTaskProvider>(create: (_) => AddTaskProvider()),
      ListenableProvider<HomeScreenProvider>(
          create: (_) => HomeScreenProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }

            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const LoginScreen();
          },
        ));
  }
}
