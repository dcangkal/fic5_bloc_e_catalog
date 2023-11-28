part of 'categories_cubit.dart';

@freezed
class CategoriesState with _$CategoriesState {
  const factory CategoriesState.initial() = _Initial;
  const factory CategoriesState.loading() = _Loading;
  factory CategoriesState.loaded(CategoriesResponseModel model) = _Loaded;
  const factory CategoriesState.error(String message) = _Error;
}
