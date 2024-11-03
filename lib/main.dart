import 'package:flutter/material.dart';
import 'view/googleBottomBar.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase for all platforms
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBd56YvEheA6dF_144vHsCXLuVNtVf087M',
        appId: '1:459147193945:android:8c2ff1b6516fddb71a4b48',
        messagingSenderId: '459147193945',
        projectId: 'nemsync-syncite',
        storageBucket: 'gs://mike-test-app-34a08.appspot.com',
      ),
    );
  } catch (e) {
    print('Firebase initialization ffailed: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'synCITE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: GoogleBottomBar(), // Use GoogleBottomBar widget here
    );
  }
}
