import 'package:bloc/bloc.dart';
import 'package:ecommerce_test/core/util/storage_helper.dart';
import 'package:ecommerce_test/dependency_injection.dart';
import 'package:ecommerce_test/feature/data/model/user_response.dart';
import 'package:ecommerce_test/feature/data/repository/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());

      var response = await repository.Login(loginData: {
        'phone': event.email,
        'password': event.password,
        'country': 'ETH'
      });

      response.fold((l) => emit(LoginError(message: l.error.message??'Error happend')), (r) async {
        emit(LoginSuccess());
        await sl<LocalStorageService>()
            .saveStringToDisk("token", r['data']['token']);
      });
    });

    on<GetUserData>((event, emit) async {
      emit(UserDataLoading());

      var response = await repository.GetUserData();
      response.fold((failur) => emit(UserDataLoadingError(message: failur.error.message??'Error happend')),
          (response) => emit(UserDataLoaded(userData: response)));
    });
  }
}
