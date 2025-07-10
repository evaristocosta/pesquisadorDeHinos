import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pesquisadorhinos/view/inicial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  runApp(Pesquisador());
}
