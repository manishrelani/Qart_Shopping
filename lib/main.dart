import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Bloc/product/product_bloc.dart';
import 'package:shopping/Screen/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Colors.grey.shade100,
      ),
      home: BlocProvider(
        create: (context) => ProductBloc(),
        child: HomeScreen(),
      ),
    );
  }
}
