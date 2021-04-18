import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class newnote extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          RaisedButton(onPressed:() {
            ref.add({
              'title':title.text,
              'content':content.text,
            }).whenComplete(() => Navigator.pop(context));
          },child: Text('save'),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration:  BoxDecoration(border: Border.all()),
            child: TextField(
              decoration: InputDecoration(hintText: ('title')),
              controller: title,
            ),
          ),
          Expanded(
              child:Container(
                decoration:  BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: content,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(hintText: ('content')),
                ),
              )
          )
        ],
      ),
    );
  }
}
