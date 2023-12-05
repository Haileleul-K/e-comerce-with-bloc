import 'package:ecommerce_test/core/app_theam.dart';
import 'package:ecommerce_test/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_test/feature/presentation/bloc/categories_bloc/catagories_bloc.dart';
import 'package:ecommerce_test/feature/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:ecommerce_test/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dependency_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<CatagoriesBloc>(),
        ),
      
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(320, 658),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: AppTheme.lightSecondaryColor
        ),
        initialRoute: Paths.splash,
        builder: EasyLoading.init(),
        onGenerateRoute: AppNavigator.onGenerateRoute,
        navigatorKey: AppNavigator.navigatorKey,
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppTheme.secondaryColor 
    ..backgroundColor = AppTheme.lightOnPrimaryColor 
    ..indicatorColor =AppTheme.secondaryColor
    ..textColor = AppTheme.secondaryColor 
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}
