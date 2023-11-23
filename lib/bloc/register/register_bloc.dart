import 'package:fic_5/data/datasources/auth_datasources.dart';
import 'package:fic_5/data/models/request/register_request_model.dart';
import 'package:fic_5/data/models/response/register_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDatasource datasource;
  RegisterBloc(this.datasource) : super(RegisterInitial()) {
    on<DoRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      //kirim
      final result = await datasource.register(event.model);
      result.fold((error) {
        emit(RegisterError(message: error));
      }, (data) {
        emit(RegisterLoaded(model: data));
      });
    });
  }
}
