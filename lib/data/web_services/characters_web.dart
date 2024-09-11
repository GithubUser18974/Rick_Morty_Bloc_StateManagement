import 'package:dio/dio.dart';
import 'package:untitled4/constants/constStrings.dart';

class CharacterWebService {
  late Dio dio;
  CharacterWebService() {
    BaseOptions option = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(milliseconds: 20000),
      receiveTimeout: Duration(milliseconds: 20000),
    );
    dio = Dio(option);
  }
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      print("Web servies ****************");
      print(response.data.toString());
      print("Web servies ****************");
      return response.data["results"];
    } catch (e) {
      print("Web servies RROr ****************");

      print(e.toString());
      return [];
    }
  }
}
