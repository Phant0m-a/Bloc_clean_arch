import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inbloc_clean/core/utils/constants/app_local_storage_keys.dart';
import 'package:inbloc_clean/core/utils/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: const SplashScreenContent(),
    );
  }
}

class SplashScreenContent extends StatefulWidget {
  const SplashScreenContent({Key? key}) : super(key: key);

  @override
  State<SplashScreenContent> createState() => _SplashScreenContentState();
}

class _SplashScreenContentState extends State<SplashScreenContent> {
  checkUser() async {
    await Future.delayed(const Duration(seconds: 1));
    final SharedPreferences sharedPreferences = sl();
    final response =
        sharedPreferences.getString(AppLocalStorageKeys.kUserDataKey);
    if (response == null || response.isEmpty) {
      context.go('/login');
    } else {
      context.go('/home');
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text(
        "Splash Screen",
        style: TextStyle(fontSize: 42),
      ),
    ));
  }
}
