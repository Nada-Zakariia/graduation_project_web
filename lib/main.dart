import 'package:control_page/bloc_observer.dart';
import 'package:control_page/loginscreen/login_layout.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'kalam',
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 35),
            bodyMedium: TextStyle(fontSize: 22),
            bodySmall: TextStyle(fontSize: 16),
          ),
          scaffoldBackgroundColor: Colors.black,
        ),
        home: LoginScreen());
  }
}
