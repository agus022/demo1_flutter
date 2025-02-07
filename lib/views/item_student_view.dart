import 'package:flutter/material.dart';

class ItemStudentView extends StatelessWidget {
  const ItemStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      //width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
         children: [
          Expanded(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/61722297?v=4'),
              ),
              title: Text('Agustin Flores Silva'),
              subtitle: Text('No. Control: 20031296'),
            
            ),
          ),
          Container(
            height:MediaQuery.of(context).size.height * .16,
            
            decoration: BoxDecoration(
              color:Colors.amber,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8)
                )

            ),
          )
         ],
      ),
    );
  }
}
