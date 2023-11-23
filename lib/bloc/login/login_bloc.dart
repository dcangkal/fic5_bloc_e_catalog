import 'package:bloc/bloc.dart';
import 'package:fic_5/data/datasources/auth_datasources.dart';
import 'package:fic_5/data/models/request/login_request_model.dart';
import 'package:fic_5/data/models/response/login_response_model.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthDatasource datasource;
  LoginBloc(this.datasource) : super(LoginInitial()) {
    on<DoLoginEvent>((event, emit) async {
      emit(LoginLoading());
      final result = await datasource.login(event.model);
      result.fold((error) => emit(LoginError(message: error)),
          (data) => emit(LoginLoaded(model: data)));
    });
  }
}
