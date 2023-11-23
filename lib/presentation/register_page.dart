// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:fic_5/bloc/register/register_bloc.dart';
import 'package:fic_5/data/models/request/register_request_model.dart';
import 'package:fic_5/presentation/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController!.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'password',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              BlocConsumer<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      final model = RegisterRequestModel(
                        name: nameController!.text,
                        email: emailController!.text,
                        password: passwordController!.text,
                      );
                      context.read<RegisterBloc>().add(
                            DoRegisterEvent(
                              model: model,
                            ),
                          );
                    },
                    child: const Text('Register'),
                  );
                },
                listener: (context, state) {
                  if (state is RegisterError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  if (state is RegisterLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('register sukses with id : ${state.model.id}'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  }
                },
                // BlocListener<RegisterBloc, RegisterState>(
                //   listener: (context, state) {
                //     if (state is RegisterError) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text(state.message),
                //           backgroundColor: Colors.red,
                //         ),
                //       );
                //     }
                //     if (state is RegisterLoaded) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content:
                //               Text('register sukses with id : ${state.model.id}'),
                //           backgroundColor: Colors.green,
                //         ),
                //       );
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const LoginPage()),
                //       );
                //     }
                //   },
                //   child: BlocBuilder<RegisterBloc, RegisterState>(
                //     builder: (context, state) {
                //       if (state is RegisterLoading) {
                //         return const Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       }
                //       return ElevatedButton(
                //         onPressed: () {
                //           final model = RegisterRequestModel(
                //             name: nameController!.text,
                //             email: emailController!.text,
                //             password: passwordController!.text,
                //           );
                //           context.read<RegisterBloc>().add(
                //                 DoRegisterEvent(
                //                   model: model,
                //                 ),
                //               );
                //         },
                //         child: const Text('Register'),
                //       );
                //     },
                //   ),
                // ),
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text("sudah punya account, login disini"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
