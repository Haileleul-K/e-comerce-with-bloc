import 'dart:async';
import 'dart:convert';

import 'package:ecommerce_test/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _checkIfLogedIn() async {
    
    //  String? value = Storage.getString('isLogedIn');
    // if (value == 'true') {
    //   String? email = await Storage.getString('email');
    //   print('eeeeeeeeeeeeeeeeeeeeeeeeee $email llllllllllllllllllll $password');
    //   BlocProvider.of<AuthBloc>(context)
    //       .add(LoginEvent(email: email ?? '', password: password ?? ''));

    // if(BlocProvider.of<AuthBloc>(context).state is LoginSuccess)
    // Navigator.pushNamedAndRemoveUntil(
    //       context, Paths.navigation, (route) => route.isFirst);
    // } else {
    //   Navigator.pushNamedAndRemoveUntil(
    //       context, Paths.login, (route) => route.isFirst);
    // }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () => Navigator.pushNamedAndRemoveUntil(context, Paths.login, (route) => false));

    double bottom = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      child: SizedBox(
        height: double.infinity,
        child: Image.asset('assets/images/splashff.jpg',fit: BoxFit.cover,),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
