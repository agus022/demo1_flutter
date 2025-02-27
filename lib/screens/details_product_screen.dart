import 'package:flutter/material.dart';

class DetailsProductScreen extends StatefulWidget {
  const DetailsProductScreen({super.key});

  @override
  State<DetailsProductScreen> createState() => _DetailsProductScreenState();
}

class _DetailsProductScreenState extends State<DetailsProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    //color: Colors.grey,
                    image: DecorationImage(image: NetworkImage('https://avatars.githubusercontent.com/u/61722297?v=4',)
                    ,fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_back_ios_new_rounded,size: 15,),
                    //AGREGAR FUNCIONN PARA REGRESAR ATRAS 
                )
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: CircleAvatar(
                    
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite,color: Color(0xFFFF8400),size: 15,),
                  )
                ),  
              ],
            ),
            SizedBox(height: 10,),
            Padding(
            //padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 24),
              child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Burger Bistro' ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  Row(
                    children: [
                      Icon(Icons.local_dining,color: Color(0xFFFF8400),size: 20),
                      SizedBox(width: 10,),
                      Text('Rose Garden',style: TextStyle(color: Color(0xFF181C2E),fontSize: 15),)
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Icon(Icons.star_border_rounded,color: Color(0xFFFF8400),size: 20),
                      SizedBox(width: 10,),
                      Text('4.7' ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color(0xFF181C2E)),)
                      ,
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}