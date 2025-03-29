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
    return Scaffold(
      //appBar: AppBar(title: Text(widget.popularModel!.title),),//la palabra widget
      appBar: AppBar(title: Text(popular.title),),
    );
  }
}