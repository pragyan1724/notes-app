import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class edit extends StatefulWidget {
  DocumentSnapshot doc; //documentSnapshot reads data form firebase's database, DS is a class ,doc has a data-type DocumentSnapshot
  edit({this.doc});
  @override
  _editState createState() => _editState();
}

class _editState extends State<edit> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  @override
  void initState(){
    title = TextEditingController(text: widget.doc.data()['title']);
    content = TextEditingController(text: widget.doc.data()['content']);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          RaisedButton(onPressed:() {
            widget.doc.reference.update({
              'title':title.text,
              'content':content.text,
            }).whenComplete(() => Navigator.pop(context));
          },
            child: Text('save'),
          ),
          RaisedButton(onPressed:() {
            widget.doc.reference.delete().whenComplete(() => Navigator.pop(context));
          },
            child: Text('delete'),
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
