class PopularModel {
  String backdropPath;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  double voteAverage;
  int voteCount;

  PopularModel({
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory PopularModel.fromMap(Map<String, dynamic> popular){
   return PopularModel(
     backdropPath: popular['backdrop_path'],
     id: popular['id'],
     originalLanguage: popular['original_language'],
     originalTitle: popular['original_title'],
     overview: popular['overview'],
     popularity: popular['popularity'],
     posterPath: popular['poster_path'],
     releaseDate: popular['release_date'],//al tiro con el parseo 
     title: popular['title'],
     voteAverage: popular['vote_average'],
     voteCount: popular['vote_count'],
   );
  }

}
