import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:final_notes/pages/addnote.dart';
import 'package:final_notes/pages/viewnote.dart';
class home extends StatelessWidget {
  final ref = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('notes_app'),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (_)=>newnote()));
        },),
      body:
      StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.hasData?snapshot.data.docs.length:0 ,
              itemBuilder: (_,index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (_)=>edit(doc: snapshot.data.docs[index],)));
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    height: 150,
                    color: Colors.purple,
                    child: Column(
                      children: [
                        Text(snapshot.hasData?snapshot.data.docs[index].data()['title']:"new notes"),
                        Text(snapshot.hasData?snapshot.data.docs[index].data()['content']:"new content")
                      ],
                    ),
                  ),
                );
              },);
          }
      ),

    );
  }
}

