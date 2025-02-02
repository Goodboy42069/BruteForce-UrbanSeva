import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'signin_page.dart';
import '../../dbHelper/mongodb.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

void main() {
  runApp(const MaterialApp(home: MyHomePage()));
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    WidgetsFlutterBinding.ensureInitialized();
    await MongoDatabase.connect();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/logo.png'),
              //fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
