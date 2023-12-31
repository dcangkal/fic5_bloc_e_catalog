import 'package:fic_5/bloc/add_product/add_product_bloc.dart';
import 'package:fic_5/bloc/categories/categories_cubit.dart';
import 'package:fic_5/bloc/detail_product/detail_product_bloc.dart';
import 'package:fic_5/bloc/login/login_bloc.dart';
import 'package:fic_5/bloc/products/products_bloc.dart';
import 'package:fic_5/bloc/register/register_bloc.dart';
import 'package:fic_5/bloc/update_product/update_product_bloc.dart';
import 'package:fic_5/data/datasources/auth_datasources.dart';
import 'package:fic_5/data/datasources/categories_datasource.dart';
import 'package:fic_5/data/datasources/product_datasources.dart';
import 'package:fic_5/presentation/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(ProductDatasource()),
        ),
        BlocProvider(
          create: (context) => AddProductBloc(ProductDatasource()),
        ),
        BlocProvider(
          create: (context) => DetailProductBloc(ProductDatasource()),
        ),
        BlocProvider(
          create: (context) => UpdateProductBloc(ProductDatasource()),
        ),
        BlocProvider(
          create: (context) => CategoriesCubit(CategoriesDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
