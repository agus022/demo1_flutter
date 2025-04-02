import 'package:demo1/Models/popular_model.dart';
import 'package:flutter/material.dart';

class DetailPopularScreen extends StatefulWidget {
  DetailPopularScreen({super.key, this.popularModel});

  PopularModel? popularModel;

  @override
  State<DetailPopularScreen> createState() => _DetailPopularScreenState();
}

class _DetailPopularScreenState extends State<DetailPopularScreen> {
  @override
  Widget build(BuildContext context) {

    final popular = ModalRoute.of(context)!.settings.arguments as PopularModel;
    const space = SizedBox(height: 10,);
    return Scaffold(
      //appBar: AppBar(title: Text(widget.popularModel!.title),),//la palabra widget
      appBar: AppBar(title: Text(popular.title),
      ),
      body: Hero(
        tag: 'https://image.tmdb.org/t/p/w500/${popular.posterPath}',
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: .5,
              image: NetworkImage('https://image.tmdb.org/t/p/w500/${popular.posterPath}'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 230,
                color: Colors.red,
              ),
              space,
              Container(
                height: 200,
                color: Colors.white12,
                child: Text(popular.overview),
              ),
              space,
              Container(
                height: 120,
                color: Colors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}