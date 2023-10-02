import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inbloc_clean/features/auth/presentation/pages/login_screen.dart';
import '../../../auth/presentation/manager/bloc/authentication_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getUser() {
    context.read<AuthenticationBloc>().add(GetCachedUserEvent());
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is GetCachedUserErrorState) {
          context.go('/Login');
        } else if (state is LoadingState) {
          const CircularProgressIndicator();
        } else if (state is LogoutUserState) {
          const LoginUser();
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: state is UserLoadedState
                ? SafeArea(
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 100),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                          color: Colors.white70),
                      child: Column(
                        children: [
                          Text(
                            state.user.email,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[500]),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            state.user.name,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 20),
                          MaterialButton(
                              color: Colors.grey[400],
                              child: Text('Logout'),
                              onPressed: () {
                                context
                                    .read<AuthenticationBloc>()
                                    .add(LogoutUserEvent());
                              })
                        ],
                      ),
                    ),
                  )
                : const SafeArea(child: LoginUser()));
      },
    );
  }
}
