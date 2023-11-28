import 'package:fic_5/bloc/categories/categories_cubit.dart';
import 'package:fic_5/bloc/products/products_bloc.dart';
import 'package:fic_5/data/datasources/categories_datasource.dart';
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
    context.read<CategoriesCubit>().getAllCategories();
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
      body: Column(
        children: [
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.160,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.network(
                                  "https://images.unsplash.com/flagged/photo-1559502867-c406bd78ff24?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=685&q=80",
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 16.0),
                                Text('Item ${index + 1}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
              if (state is ProductsLoaded) {
                // debugPrint('total data : ${state.data.length}');
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.0 / 1.4,
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount:
                      state.isNext ? state.data.length + 1 : state.data.length,
                  controller: scrollController,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (state.isNext && index == state.data.length) {
                      return const Card(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    var item = state.data[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailProductPage(
                                id: state.data[index].id ?? 0),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    item.images![0],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    6.0,
                                  ),
                                ),
                              ),
                              child: const Stack(
                                children: [
                                  Positioned(
                                    right: 6.0,
                                    top: 8.0,
                                    child: CircleAvatar(
                                      radius: 14.0,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 14.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            item.title!,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "\$ ${item.price}",
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          ),
        ],
      ),
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
