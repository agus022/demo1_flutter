import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsProductScreen extends StatefulWidget {
  const DetailsProductScreen({super.key});

  @override
  State<DetailsProductScreen> createState() => _DetailsProductScreenState();
}

class _DetailsProductScreenState extends State<DetailsProductScreen> {
  int contador = 1;
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
                    child: Icon(CupertinoIcons.back,size: 15,),
                    //AGREGAR FUNCIONN PARA REGRESAR ATRAS 
                )
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: CircleAvatar(
                    
                    backgroundColor: Colors.white,
                    child: Icon(CupertinoIcons.heart_solid,color: Color(0xFFFF8400),size: 15,),
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
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(Icons.star_border_rounded,color: Color(0xFFFF8400),size: 27),
                      SizedBox(width: 5,),
                      Text('4.7' ,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Color(0xFF181C2E)),),
                      SizedBox(width: 45,),
                      Icon(Icons.delivery_dining_outlined,color: Color(0xFFFF8400),size: 27,),
                      SizedBox(width: 5,),
                      Text('Free' ,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Color(0xFF181C2E)),),
                      SizedBox(width: 45,),
                      Icon(Icons.timer_sharp,color: Color(0xFFFF8400),size: 27,),
                      SizedBox(width: 5,),
                      Text('20 min.' ,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Color(0xFF181C2E)),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text('Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.',
                   style: TextStyle(color: Color(0xFFA0A5BA)),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("SIZE:", style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFA0A5BA))),
                      SizedBox(width: 15,),
                      sizeButton(context,"10\"",35),
                      SizedBox(width: 15,),
                      sizeButton(context,"14\"",45),
                      SizedBox(width: 15,),
                      sizeButton(context,"16\"",55),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text("INGREDIENTS", style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF32343E))),
                  SizedBox(height: 20,),
                   GridView.count(
                    mainAxisSpacing: 20,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 5,
                    children: [
                      ingredientButton("Salt",Icons.fastfood_outlined),
                      ingredientButton("Chicken",Icons.local_pizza_outlined),
                      ingredientButton("Onion",Icons.local_cafe_outlined),
                      ingredientButton("Garlic",Icons.local_fire_department_outlined),
                      ingredientButton("Pappers",Icons.cake_outlined),
                      ingredientButton("Ginger",Icons.lunch_dining_outlined),
                      ingredientButton("Broccoli",Icons.ramen_dining_outlined),
                      ingredientButton("Orange",Icons.emoji_food_beverage_outlined),
                      ingredientButton("Walnut",Icons.fastfood_outlined),
                    ],
                  ),

                ],
              ),

            )
          ],
        ),
      ),
    );
  }

  Widget sizeButton(BuildContext context, String text, double price) {
    return GestureDetector(
      onTap: (){
        cardMenuBottonSheet(context ,price);
      },
      child: Container(
        width: 55,
        height: 55,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xFFF0F5FA),
          borderRadius: BorderRadius.circular(90),
          
        ),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 17),
        ),
      ),
    );
  }

  //CREAR EL 
  void cardMenuBottonSheet(BuildContext context, double price){
    showAdaptiveActionSheet(
      context: context,
      actions: [BottomSheetAction(title: Text(""), onPressed: (context){})],
      bottomSheetColor: Color(0xFFF0F5FA),
      cancelAction: CancelAction(
        title: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)
            )
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$$price",style: TextStyle(fontSize: 30),),
                  counterButton(),//inserta el boton del contador
                ],
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF7622),
                  minimumSize: Size(double.infinity,50)
                ),
                onPressed: () => Navigator.pop(context),//cierrra el menu flotante para FF7622que solo se meustre la pantalla del producto  
                child: Text('ADD CART'))
            ],
          )
        )
      )
    );
  }

Widget counterButton() {

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove, color: Colors.white),
                onPressed: () {
                  setState(() {
                  if (contador > 1) contador--;
          
                  });
                },
              ),
              Text("$contador", style: TextStyle(color: Colors.white, fontSize: 18)),
              IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  setState(() {
                    contador++;
                  });
                },
              ),
            ],
          ),
        );
      }
    );
  }

  Widget ingredientButton(String name, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          
          backgroundColor: Color(0xFFFFEBE4),
          radius: 25,
          child: Icon(icon, color: Color(0xFFFB6D3A)), 
        ),
        SizedBox(height: 5),
        Text(name, style: TextStyle(fontSize: 15,color: Color(0xFF747783))),
      ],
    );
  }
}
