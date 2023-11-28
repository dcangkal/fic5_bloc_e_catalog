import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic_5/data/models/response/categories_response_model.dart';
import 'package:http/http.dart' as http;

class CategoriesDatasource {
  Future<Either<String, List<CategoriesResponseModel>>>
      getAllCategories() async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/categories/'),
    );
    if (response.statusCode == 200) {
      return Right(
        List<CategoriesResponseModel>.from(
          jsonDecode(response.body).map(
            (x) => CategoriesResponseModel.fromMap(x),
          ),
        ),
      );
    } else {
      return const Left('get categories error');
    }
  }
}
