import 'package:get_it/get_it.dart';
import 'package:i_called/core/firebase/firebase_helper.dart';
import 'package:i_called/features/auth/data/datasource/remote_data_source.dart';
import 'package:i_called/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:i_called/features/auth/domain/repositories/auth_repo.dart';
import 'package:i_called/features/auth/domain/usecase/check_user_log_in_status.dart';
import 'package:i_called/features/auth/domain/usecase/login_usecase.dart';
import 'package:i_called/features/auth/domain/usecase/sign_up_usecase.dart';

class SetUpLocators {
  static const SetUpLocators _instance = SetUpLocators._();
  const SetUpLocators._();
  factory SetUpLocators() => _instance;

  static final getIt = GetIt.instance;

  static void init() {
    /// Data
    getIt.registerLazySingleton<AuthenticationRemoteDataSourceImpl>(
      () => AuthRemoteDataSourceImpl(firebaseHelper: FirebaseHelper()),
    );

    /// UseCases
    getIt.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(
        authenticationRepository: getIt<AuthRepository>(),
      ),
    );
    getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(
        authenticationRepository: getIt<AuthRepository>(),
      ),
    );
    getIt.registerLazySingleton<CheckUserLogInStatusUsecase>(
      () => CheckUserLogInStatusUsecase(
        authenticationRepository: getIt<AuthRepository>(),
      ),
    );

    /// Repository
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authenticationRemoteDataSource:
            getIt<AuthenticationRemoteDataSourceImpl>(),
      ),
    );
  }
}
