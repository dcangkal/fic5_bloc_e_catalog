import 'package:fic_5/bloc/add_product/add_product_bloc.dart';
import 'package:fic_5/bloc/products/products_bloc.dart';
import 'package:fic_5/data/models/request/product_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController? titleController;
  TextEditingController? descriptionController;
  TextEditingController? priceController;
  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    super.initState();
    context.read<ProductsBloc>().add(GetProductEvent());
  }

  @override
  void dispose() {
    titleController!.dispose();
    descriptionController!.dispose();
    priceController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'price'),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("cancel"),
                  ),
                  BlocConsumer<AddProductBloc, AddProductState>(
                    listener: (context, state) {
                      if (state is AddProductLoaded) {
                        const snackBarSukses = SnackBar(
                          content: Text('add product success'),
                          backgroundColor: Colors.green,
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBarSukses);
                        context.read<ProductsBloc>().add(GetProductEvent());
                        titleController!.clear();
                        descriptionController!.clear();
                        priceController!.clear();
                        Navigator.pop(context);
                      }
                      if (state is AddProductError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("add product ${state.message}"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      if (state is AddProductLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          final model = ProductRequestModel(
                            title: titleController!.text,
                            price: int.parse(priceController!.text),
                            description: descriptionController!.text,
                          );
                          context.read<AddProductBloc>().add(
                                DoAddProductEvent(model: model),
                              );
                        },
                        child: const Text("add"),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
