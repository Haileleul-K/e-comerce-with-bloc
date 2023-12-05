import 'package:ecommerce_test/core/app_theam.dart';
import 'package:ecommerce_test/dependency_injection.dart';
import 'package:ecommerce_test/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_test/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  bool _hidePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            EasyLoading.dismiss();
            Navigator.pushNamedAndRemoveUntil(
                context, Paths.navigation, (route) => route.isFirst);
          }
          if (state is LoginError) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.message, dismissOnTap: true);
          }
          if (state is LoginLoading) {
            EasyLoading.show();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            child: Stack(children: [
              Align(
                alignment: Alignment.topCenter,
                // heightFactor: screenHeight/2,
                child: Image.asset(
                  'assets/images/signinff.png',
                  fit: BoxFit.fill,
                  height: screenHeight / 1.95,
                  width: screenWidth,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                heightFactor: screenHeight / 2,
                child: loginBottom(context),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget loginBottom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign In',
                style: AppTheme.lightHeadingText(fsize: 20),
              ),
              Form(
                  key: _key,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter email';
                            }
                            if (!(_emailController.text.startsWith('09')||_emailController.text.startsWith('9'))) {
                              return 'Field should start with 09 or 9';
                            }
                          },
                          onEditingComplete: () {
                            _emailFocusNode.unfocus();
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                          style: AppTheme.lightBodyText(fsize: 17, false),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 20.h),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: '912121212',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          obscureText: _hidePassword,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            _passwordFocusNode.unfocus();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 20.h),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hidePassword = !_hidePassword;
                                });
                              },
                              icon: _hidePassword == true
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: AppTheme.lightOnPrimaryColor,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: AppTheme.lightOnPrimaryColor,
                                    ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: '12345678',
                          ),
                          style: AppTheme.lightBodyText(false, fsize: 17),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              if (_emailController.text.startsWith('09')) {
                                _emailController.text = _emailController.text.split('0')[1];
                              }
                              sl<AuthBloc>().add(
                                LoginEvent(
                                  email: "251${_emailController.text}",
                                  password: _passwordController.text,
                                ),
                              );
                            } else {
                              autovalidateMode =
                                  AutovalidateMode.onUserInteraction;
                            }
                          },
                          child: Text('SIGN IN',
                              style: AppTheme.lightHeadingText(fsize: 16)),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              foregroundColor: AppTheme.textColorPrimary,
                              backgroundColor: AppTheme.lightSecondaryColor),
                        )
                        // DefaultButton(
                        //   text: "Login",
                        //   press: () {
                        //     authBloc!.add(LoginEvent(
                        //         email: _emailController.text,
                        //         password: _passwordController.text));
                        //   },
                        // ),
                      ]))
            ]),
      ),
    );
  }
}
