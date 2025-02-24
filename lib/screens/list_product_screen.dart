import 'package:demo1/views/item_food_view.dart';
import 'package:flutter/material.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('My Food List',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          bottom: TabBar(
            labelColor: Color(0xFFFB6D3A),
            unselectedLabelColor: Colors.black54,
            indicatorColor: Color(0XFFFB6D3A),
            tabs: const [
              Tab(
                text: "All",
              ),
              Tab(
                text: "Breakfast",
              ),
              Tab(
                text: "Lunch",
              ),
              Tab(
                text: "Dinner",
              )
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ItemFoodView(),
            SizedBox(height: 10,),
            ItemFoodView(),
            SizedBox(height: 10,),
            ItemFoodView(),
            SizedBox(height: 10,),
            ItemFoodView(),
            SizedBox(height: 10,),
            ItemFoodView(),
            SizedBox(height: 10,),
            ItemFoodView(),
            SizedBox(height: 10,),
            ItemFoodView()
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 1,
            )
          ]),
          child: DefaultTabController(
            length: 5,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined, size: 32,), label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.menu, size:32 ,), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle_sharp,
                        size: 42, color: Color(0XFFFB6D3A)),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_none_outlined, size: 32,), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline, size: 32,), label: "")
              ],
              selectedItemColor: Color(0XFFFB6D3A),
              unselectedItemColor: Color(0xFFAFAFAF),
              selectedLabelStyle: TextStyle(fontSize: 14),
              unselectedLabelStyle: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
