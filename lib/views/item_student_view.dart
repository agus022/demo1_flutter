import 'package:flutter/material.dart';

class ItemStudentView extends StatelessWidget {
  const ItemStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      //width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        //color: Colors.grey,
        border: Border.all(color: Color(0xFF006BDB)),
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
              color:Color(0xFFEDF3FF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8)
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Table(
                    children:[
                    TableRow(
                      children: [
                        Center(child: Text('Semestre',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF006BDB)))),
                        Center(child: Text('Clave Materia',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF006BDB)))),
                        Center(child: Text('Grupo',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF006BDB))))
                      ],
                    ),
                    TableRow(
                      children: [
                        Center(child: Text('9')),
                        Center(child: Text('M10')),
                        Center(child: Text('A'))
                      ],
                    ),
                    ]
                  ),
                  SizedBox(height: 16,),
                  Text('INGENIERIA EN SISTEMAS COMPUTACIONALES',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  
                  )
                ],
              ),
            ),
          )
         ],
      ),
    );
  }
}
