import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ItemFoodView extends StatelessWidget {
  const ItemFoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 100,
      //width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        //border: Border.all(color: Color(0xFFAFAFAF)),
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 4,
        //     spreadRadius: 1
        //   )
        // ]
        
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network('https://avatars.githubusercontent.com/u/61722297?v=4',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width:5,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chicken Thai Biriyani',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),

                SizedBox(height: 5,),
                
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(82, 255, 119, 34),
                    borderRadius:BorderRadius.circular(15),
                  ),
                  child: Text('Breakfast', style: TextStyle(color: Color.fromARGB(139, 255, 119, 34),fontSize: 12, fontWeight: FontWeight.bold)),
                ),

                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.star,color: Color(0XFFFB6D3A),size: 18,),
                    SizedBox(width: 2),
                    Text("4.9 ",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Color(0XFFFB6D3A)),),
                    SizedBox(width: 2),
                    Text("(100 Reviews)",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Color(0xFFAFAFAF)),),
                  ],
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.more_horiz_rounded,color: Colors.black54,),
              //IconButton(icon: Icon(Icons.more_horiz_rounded, color: Colors.black54,), onPressed: () {  },)
              Text('\$60',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height:10 ,),
              Text('Pick Up',style: TextStyle(fontSize: 12,color: Color(0xFFAFAFAF))),

            ],
          )
         ],
      ),
    );
  }
}