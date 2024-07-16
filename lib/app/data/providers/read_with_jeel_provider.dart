import 'package:dio/dio.dart';

import '../../core/values/endpoint_constants.dart';
import '../models/ResponseModel.dart';
import '../models/book_model.dart';
import '../services/dio_client.dart';

class BooksCategoryAPIProvider {
  final DioClient _dioClient = DioClient.instance;
  Future<Response?> getBooksCategory() async {
    try {
      Response response =
          await _dioClient.get(EndPoints.GET_ALL_CATEGORIES_OF_BOOKS);
      print(response.data);
      return response;
    } catch (error) {
      print("Exception: $error");
      return null;
    }
  }
}

class BooksRepository {
  BooksAPIProvider booksAPIProvider = BooksAPIProvider();

  Future<Books> getAllActiveBooks() => booksAPIProvider.getAllActiveBooks();

  Future<ResponseModel> getBookParentWithActiveBooks(int? id) async {
    final response = await booksAPIProvider.getBookParentWithActiveBooks(id);
    return ResponseModel.fromResponse(response, 'books');
  }
}

class BooksAPIProvider {
  final DioClient _dioClient = DioClient.instance;

  Future<Books> getAllActiveBooks() async {
    try {
      Response response = await _dioClient.get(EndPoints.GET_ACTIVE_BOOKS);
      return Books.fromJson(response.data);
    } catch (error) {
      return Books.withError("$error");
    }
  }

  Future<Response?> getBookParentWithActiveBooks(int? id) async {
    try {
      Map<String, dynamic> queryParam = {
        "ID": id.toString(),
      };
      Response response = await _dioClient.get(EndPoints.GET_BOOKS_CHILDS,
          queryParameters: queryParam);
      return response;
    } catch (error) {
      return null;
    }
  }
}

class BooksCategoryRepository {
  Future<ResponseModel> getBooksCategory() async {
    final response = await BooksCategoryAPIProvider().getBooksCategory();
    return ResponseModel.fromResponse(response, 'results');
  }
}
