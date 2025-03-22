import 'package:demo1/apis/popular_api.dart';
import 'package:flutter/material.dart';

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
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2
              ),
              itemBuilder: (context, index) {
                  
              },
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        }
      )
    );
  }
}