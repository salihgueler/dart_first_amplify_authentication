import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';

Future<void> main() async {
  await _configureAmplify();

  runApp(const DartFirstAmplifyAuthenticationApp());
}

Future<void> _configureAmplify() async {
  try {
    final authPlugin = AmplifyAuthCognito();
    await Amplify.addPlugin(authPlugin);

    await Amplify.configure(amplifyconfig);
  } catch (e) {
    safePrint('An error occurred while configuring Amplify: $e');
  }
}

class DartFirstAmplifyAuthenticationApp extends StatelessWidget {
  const DartFirstAmplifyAuthenticationApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        title: 'Amplify Dart First Authentication Demo',
        home: const MyHomePage(title: 'Amplify Dart First Authentication Demo'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FutureBuilder<AuthUser>(
                future: Amplify.Auth.getCurrentUser(),
                builder: (context, currentUserSnapshot) {
                  if (currentUserSnapshot.connectionState ==
                      ConnectionState.active) {
                    return const Text('Loading user');
                  } else {
                    return Text(
                      'Welcome ${currentUserSnapshot.data?.username}',
                    );
                  }
                },
              ),
            ),
            const SignOutButton(),
          ],
        ),
      ),
    );
  }
}