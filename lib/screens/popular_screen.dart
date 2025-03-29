import 'package:demo1/apis/popular_api.dart';
import 'package:flutter/material.dart';
import 'package:demo1/Models/popular_model.dart';
import 'package:demo1/screens/detail_popular_screen.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  PopularApi? popular;

  @override
  void initState() {
    super.initState();
    popular = PopularApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular Movie')),
      body: FutureBuilder(
        future: popular!.getHttpPopular(), 
        builder: (context, snapshot){
          if(snapshot.hasData){
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ItemPopular(snapshot.data![index]);
                  
              },
            );
          }else{
            if(snapshot.hasError){
              return Center(child: Text('Ocurrio un error'),);
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
        }
      )
    );
  }

  Widget ItemPopular(PopularModel popular){
    return InkWell(
      onTap: () {
        //print('hola desde mis imagenes');
        //Navigator.push(context, MaterialPageRoute(builder:(context)=> DetailPopularScreen(popularModel: popular,)));
        Navigator.pushNamed(context, '/movieDetail',arguments: popular);
      },
      child: Container(
        height: 200,
        decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage(
            fadeInDuration: Duration(seconds: 5),
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/loading.gif'), 
            image: NetworkImage('https://image.tmdb.org/t/p/w500/${popular.posterPath}'),
          ),
        )
      ),
    );
  }
}