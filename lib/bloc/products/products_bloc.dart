// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:fic_5/data/datasources/product_datasources.dart';
import 'package:fic_5/data/models/response/product_response_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductDatasource datasource;
  ProductsBloc(
    this.datasource,
  ) : super(ProductsInitial()) {
    on<GetProductEvent>((event, emit) async {
      emit(ProductsLoading());
      final result =
          await datasource.getPaginationProduct(offset: 0, limit: 10);
      result.fold(
          (error) => emit(
                ProductsError(message: error),
              ), (result) {
        bool isNext = result.length == 10;
        emit(ProductsLoaded(data: result, isNext: isNext));
      });
    });

    on<NextProductEvent>((event, emit) async {
      final currentState = state as ProductsLoaded;
      final result = await datasource.getPaginationProduct(
          offset: currentState.offset + 10, limit: 10);
      result.fold(
        (error) => emit(
          ProductsError(message: error),
        ),
        (result) {
          bool isNext = result.length == 10;
          emit(ProductsLoaded(
            data: [...currentState.data, ...result],
            offset: currentState.offset + 10,
            isNext: isNext,
          ));
        },
      );
    });
  }
}
