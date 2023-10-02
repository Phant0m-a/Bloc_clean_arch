import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../manager/bloc/authentication_bloc.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginState) {
          context.read<AuthenticationBloc>().add(
                CacheUserEvent(name: state.user.name, email: state.user.email),
              );
          context.go('/home');
        } else if (state is AuthenticationErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Builder(builder: (context) {
            return SafeArea(child: _buildLoginForm(context));
          }),
        );
      },
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text('Login',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            _buildTextField(
              controller: email,
              labelText: 'Email',
              hintText: 'Enter valid email id as abc@gmail.com',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email is required';
                }
                // Validate email format using regex
                final emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
            _buildTextField(
              controller: password,
              labelText: 'Password',
              hintText: 'Enter secure password',
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: MaterialButton(
                  color: Colors.grey.shade400,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthenticationBloc>().add(
                            LoginUserEvent(
                                email: email.text, password: password.text),
                          );
                    }
                  },
                  child: const Text(
                    'Log in',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
