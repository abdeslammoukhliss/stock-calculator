import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stcok_calculator/pages/main_page.dart';
import 'package:stcok_calculator/pages/products_page.dart';
import 'package:stcok_calculator/services/csv_service.dart';
import 'package:stcok_calculator/services/fire_storage_service.dart';
import 'package:stcok_calculator/services/prodcut_service.dart';
import 'package:stcok_calculator/services/product_service_csv.dart';

import 'controllers/user_controller.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserController(productService:  ProductServiceCSV(),fireStorageService: FireStorageService(),csvService: CSVService())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        initialRoute: '/',
        routes: {
          '/': (context) => MainPage(),
          '/products': (context) => ProductsPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),

          ],
        ),
      ),
    );
  }
}
