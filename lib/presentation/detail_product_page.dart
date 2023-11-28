// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fic_5/bloc/detail_product/detail_product_bloc.dart';
import 'package:fic_5/bloc/update_product/update_product_bloc.dart';
import 'package:fic_5/data/models/request/product_request_model.dart';
import 'package:fic_5/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailProductPage extends StatefulWidget {
  final int id;
  const DetailProductPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  TextEditingController? titleController;
  TextEditingController? descriptionController;
  TextEditingController? priceController;

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    context.read<DetailProductBloc>().add(GetDetailProductEvent(id: widget.id));

    super.initState();
    // context.read<ProductsBloc>().add(GetProductEvent());
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
        elevation: 2,
        title: Text("Detail Product ${widget.id}"),
        actions: const [],
      ),
      body: BlocBuilder<DetailProductBloc, DetailProductState>(
        builder: (context, state) {
          if (state is DetailProductLoaded) {
            return ListView.builder(
              itemCount: 1,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        color: Colors.white70,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 2,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                state.data.images![0],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "${state.data.title}",
                            style: const TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "${state.data.description}",
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "\$ ${state.data.price}",
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return BlocBuilder<DetailProductBloc, DetailProductState>(
                  builder: (context, state) {
                    if (state is DetailProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is DetailProductLoaded) {
                      titleController?.text = state.data.title!;
                      descriptionController?.text = state.data.description!;
                      priceController?.text = state.data.price.toString();
                      return AlertDialog(
                        title: Text('Update Product ${state.data.id}'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextField(
                                controller: titleController,
                                decoration:
                                    const InputDecoration(labelText: 'Title'),
                              ),
                              TextField(
                                controller: descriptionController,
                                decoration: const InputDecoration(
                                  labelText: 'Description',
                                ),
                                maxLines: 5,
                              ),
                              TextField(
                                controller: priceController,
                                decoration:
                                    const InputDecoration(labelText: 'Price'),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          BlocConsumer<UpdateProductBloc, UpdateProductState>(
                            listener: (context, state) {
                              if (state is UpdateProductLoaded) {
                                const snackBarSukses = SnackBar(
                                  content: Text('update product success'),
                                  backgroundColor: Colors.green,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBarSukses);
                                context
                                    .read<DetailProductBloc>()
                                    .add(GetDetailProductEvent(id: widget.id));
                                titleController!.clear();
                                descriptionController!.clear();
                                priceController!.clear();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                );
                              }
                              if (state is UpdateProductError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text("update product ${state.message}"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                Navigator.pop(context);
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  final model = ProductRequestModel(
                                    title: titleController!.text,
                                    price: int.parse(priceController!.text),
                                    description: descriptionController!.text,
                                  );
                                  context.read<UpdateProductBloc>().add(
                                      DoUpdateProductEvent(
                                          model: model, id: widget.id));
                                },
                                child: const Text("Update"),
                              );
                            },
                          ),
                        ],
                      );
                    }
                    return const Center(
                      child: Text("gagal"),
                    );
                  },
                );
              });
        },
        child: const Icon(
          Icons.edit_note_outlined,
          size: 32.0,
        ),
      ),
    );
  }
}
