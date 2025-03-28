import 'package:demo1/Models/popular_model.dart';
import 'package:dio/dio.dart';

class PopularApi{

  final dio = Dio();
  Future<List<PopularModel>?> getHttpPopular () async{
    final response = await dio.get('https://api.themoviedb.org/3/movie/popular?api_key=5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1');
    if(response.statusCode == 200){
      final res = response.data['results'] as List;
      return res.map((movie) => PopularModel.fromMap(movie)).toList();
    }
    return null;
  }

}