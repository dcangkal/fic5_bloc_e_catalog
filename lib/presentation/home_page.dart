import 'package:fic_5/bloc/products/products_bloc.dart';
import 'package:fic_5/data/datasources/local_datasources.dart';
import 'package:fic_5/presentation/add_product_page.dart';
import 'package:fic_5/presentation/detail_product_page.dart';
import 'package:fic_5/presentation/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(GetProductEvent());
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        context.read<ProductsBloc>().add(NextProductEvent());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        elevation: 5,
        actions: [
          IconButton(
              onPressed: () async {
                await LocalDatasource().removeToken();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
        if (state is ProductsLoaded) {
          debugPrint('total data : ${state.data.length}');
          return ListView.builder(
              controller: scrollController,
              // reverse: true,
              itemCount:
                  state.isNext ? state.data.length + 1 : state.data.length,
              itemBuilder: (context, index) {
                if (state.isNext && index == state.data.length) {
                  return const Card(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailProductPage(id: state.data[index].id ?? 0),
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(state.data[index].title ?? '-'),
                      subtitle: Text('\$ ${state.data[index].price}'),
                    ),
                  ),
                );
              });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
