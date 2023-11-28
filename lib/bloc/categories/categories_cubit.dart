// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic_5/data/datasources/categories_datasource.dart';
import 'package:fic_5/data/models/response/categories_response_model.dart';

part 'categories_cubit.freezed.dart';
part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesDatasource datasource;
  CategoriesCubit(
    this.datasource,
  ) : super(const CategoriesState.initial());

  void getAllCategories() async {
    emit(const _Loading());
    final result = await datasource.getAllCategories();
    result.fold(
        (error) => emit(
              _Error(error),
            ), (result) {
      emit(_Loaded(result));
    });
  }
}
