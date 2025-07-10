import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:pesquisadorhinos/view/inicial.dart';

void main() async { // Make main async
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widgets are initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(Pesquisador());
}
