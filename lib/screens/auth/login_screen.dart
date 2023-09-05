import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xyz/screens/auth/register_screen.dart';

import '../../provider/auth_provider.dart';
import '../widgets/connection_check.dart';
import '../widgets/custom_alert_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ConnectionCheck(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: provider.formKeyLogin,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Email Address',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  //allow upper and lower case alphabets and space
                                  return "Please enter a valid Email address";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                provider.enteredEmail = value!;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                // icon: Icon(Icons.lock_outline),
                                labelText: 'Password',
                              ),
                              controller: passController,
                              obscureText: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().length < 6 ||
                                    value.trim().length > 20) {
                                  return 'Password must be between 6-20 characters';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                provider.enteredPassword = value!;
                              },
                            ),
                            const SizedBox(height: 12),
                            if (provider.isAuthenticating)
                              const CircularProgressIndicator(),
                            if (!provider.isAuthenticating)
                              ElevatedButton(
                                onPressed: () {
                                  if (emailController.text.isEmpty ||
                                      passController.text.isEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => const CustomAlertDialog(
                                          title: 'Login error!',
                                          content:
                                              'Please dont leave files empty'),
                                    );
                                  } else {
                                    provider.login(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
                                child: const Text("Login"),
                              ),
                            if (!provider.isAuthenticating)
                              const SizedBox(
                                height: 8,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Don’t have an account? ',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Register',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const RegisterScreen()));
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
