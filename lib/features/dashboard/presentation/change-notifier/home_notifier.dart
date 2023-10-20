import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:i_called/core/failures/failures.dart';
import 'package:i_called/core/utils/snack_bar_service.dart';
import 'package:i_called/features/auth/data/models/user_model.dart';
import 'package:i_called/features/auth/domain/usecase/check_user_log_in_status.dart';
import 'package:i_called/features/auth/domain/usecase/get_user_model_usecase.dart';
import 'package:i_called/features/dashboard/data/model/meeting_details_model.dart';

import 'package:i_called/features/dashboard/domain/usecase/get_users_usecase.dart';

class HomeNotifier extends ChangeNotifier {
  final GetUsersUsecase getUsersUsecase;
  final GetUserModelUsecase getUserModelUsecase;

  HomeNotifier({
    required this.getUsersUsecase,
    required this.getUserModelUsecase,
  });

  bool isLoading = false;

  Stream<List<UserModel>>? _userModelList;
  Stream<List<UserModel>>? get userList => _userModelList;
  Future<Either<Failures, Stream<List<UserModel>>>> getUser(
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();

    final data = await getUsersUsecase.call(NoParams());
    return data.fold(
      (l) {
        isLoading = false;
        notifyListeners();

        SnackBarService.showSuccessSnackBar(
          context: context,
          message: l.message,
        );
        return Left(l);
      },
      (r) {
        isLoading = false;
        notifyListeners();
        _userModelList = r;
        notifyListeners();
        return Right(r);
      },
    );
  }

  UserModel? userModel;
  Future<Either<Failures, UserModel?>> getCurrentUserDetails(
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();
    final data = await getUserModelUsecase.call(NoParams());
    return data.fold(
      (l) {
        isLoading = false;
        notifyListeners();

        SnackBarService.showSuccessSnackBar(
          context: context,
          message: l.message,
        );
        return Left(l);
      },
      (r) {
        isLoading = false;
        notifyListeners();
        userModel = r;
        notifyListeners();
        return Right(r);
      },
    );
  }

  MeetingDetails userMeetingDetails = const MeetingDetails();

  String getUserMeetingID() {
    final String id = userMeetingDetails.generateId();
    return id;
  }
}
