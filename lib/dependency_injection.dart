import 'package:ecommerce_test/core/util/api_helper.dart';
import 'package:ecommerce_test/core/util/storage_helper.dart';
import 'package:ecommerce_test/feature/data/datasource/auth_datasource.dart';
import 'package:ecommerce_test/feature/data/datasource/category_datasource.dart';
import 'package:ecommerce_test/feature/data/datasource/home_datasource.dart';
import 'package:ecommerce_test/feature/data/repository/auth_repo.dart';
import 'package:ecommerce_test/feature/data/repository/category._repo.dart';
import 'package:ecommerce_test/feature/data/repository/home_repo.dart';
import 'package:ecommerce_test/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_test/feature/presentation/bloc/categories_bloc/catagories_bloc.dart';
import 'package:ecommerce_test/feature/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:ecommerce_test/routes.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


GetIt sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<ApiBaseHelper>(ApiBaseHelper());
  var instance = await LocalStorageService.getInstance();
  sl.registerSingleton<LocalStorageService>(instance);
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => DatabaseHelper());
  sl.registerSingleton<AppNavigator>(AppNavigator());
  // sl.registerLazySingleton(() => InternetConnectionChecker());


  //services
sl.registerLazySingleton<AuthService>(() => AuthService());
sl.registerLazySingleton<HomeServies>(() => HomeServies());
sl.registerLazySingleton<CategoryService>(() => CategoryService());
  // sl.registerLazySingleton(() => InternetConnectionChecker());



//bloc

  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(sl()));
  sl.registerLazySingleton<HomeBloc>(() => HomeBloc(sl()));
  sl.registerLazySingleton<CatagoriesBloc>(() => CatagoriesBloc(sl()));


  //repository

sl.registerFactory<AuthRepository>(
      () => AuthRepositoryImply(authService: sl()));
sl.registerFactory<HomeRepository>(
      () => HomeRepositoryImply(homeServies: sl()));
      sl.registerFactory<CategoryRepository>(
      () => CategoryRepositoryImply(categoryService: sl()));
}
