// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:fic_5/bloc/login/login_bloc.dart';
import 'package:fic_5/data/datasources/local_datasources.dart';
import 'package:fic_5/data/models/request/login_request_model.dart';
import 'package:fic_5/presentation/home_page.dart';
import 'package:fic_5/presentation/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    checkAuth();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  void checkAuth() async {
    // await Future.delayed(const Duration(seconds: 1));
    final auth = await LocalDatasource().getToken();
    if (auth.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
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
              BlocConsumer<LoginBloc, LoginState>(builder: (context, state) {
                if (state is LoginLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    final model = LoginRequestModel(
                      email: emailController!.text,
                      password: passwordController!.text,
                    );
                    context.read<LoginBloc>().add(
                          DoLoginEvent(
                            model: model,
                          ),
                        );
                  },
                  child: const Text('Login'),
                );
              }, listener: (context, state) {
                if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                if (state is LoginLoaded) {
                  LocalDatasource().saveToken(state.model.accessToken);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('login sukses'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }
              }),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text("belum punya account, register disini"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
