import 'package:demo1/Models/popular_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class DetailPopularScreen extends StatefulWidget {
  DetailPopularScreen({super.key, this.popularModel});

  PopularModel? popularModel;

  @override
  State<DetailPopularScreen> createState() => _DetailPopularScreenState();
}

class _DetailPopularScreenState extends State<DetailPopularScreen> {
  YoutubePlayerController? _controller;
  
  
  @override
  void initState(){
    super.initState();
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _controller =YoutubePlayerController.fromVideoId(
      videoId: "jan5CFWs9ic",
    );
  }

  @override
  Widget build(BuildContext context) {

    final popular = ModalRoute.of(context)!.settings.arguments as PopularModel; 
    const space = SizedBox(height: 10,);
    return Scaffold(
      //appBar: AppBar(title: Text(widget.popularModel!.title),),//la palabra widget
      appBar: AppBar(title: Text(popular.title),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
         decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:[
              Colors.white, 
              Colors.black] 
          )
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 230,
              child: YoutubePlayer(
                controller: _controller!,
                aspectRatio: 16/9,
              ),
            ),
            space,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 80,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        popular.title,
                        style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5,),
                      Text(popular.releaseDate.split('-')[0],
                        style: const TextStyle(color: Colors.black38, fontSize: 10),
                      ),
                    ],
                    
                  ),
                  
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      StarRating(
                        rating: popular.voteAverage / 2, // Ajusta a 5 estrellas
                        starCount: 5,
                        color: Colors.amber,
                        size: 17,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "From ${popular.voteCount} users",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  )
                  // StarRating(
                  //   rating: popular.voteAverage / 2,
                  //   starCount: 5,
                  //   color: Colors.amber,
                  //   size:17,
                  // ),
                ],
              ),
              
            ),
            space,
            Container(
              height: 200,
              //color: Colors.white12,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Agrega margen alrededor
              child: Row(
                children: [
                  Hero(
                    tag: 'https://image.tmdb.org/t/p/w500/${popular.posterPath}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15), // Redondea los bordes
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500/${popular.posterPath}',
                        width: 120, // Ajusta el ancho de la imagen si es necesario
                        height: 180, // Ajusta la altura de la imagen si es necesario
                        fit: BoxFit.cover, // Ajusta cómo se muestra la imagen
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Espacio entre la imagen y el texto
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .55,
                    child: Text(
                      popular.overview,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            space,
            Container(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}