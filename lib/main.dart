import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(HelloWorldApp());

class HelloWorldApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HelloWorldPage(),
    );
  }
}

class HelloWorldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Firebase',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: new StreamBuilder(
          stream: Firestore.instance.collection('example_document').snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return new Padding(
                padding: EdgeInsets.all(50.0),
                child: new Center(
                  child: new CircularProgressIndicator(),
                ),
              );
            }
            else{
              return _loadImage(context, snapshot.data.documents[0]);
            }
          }
        ),
      ),
    );
  }
  Widget _loadImage(BuildContext context, DocumentSnapshot document){    
    return new Stack(
      children: <Widget>[
        new Image.network(
          document['url'],
          width: 250,
          height: 250,
        ),
        new FadeInImage(
          placeholder: NetworkImage('https://firebasestorage.googleapis.com/v0/b/dscflutterevent.appspot.com/o/ZNeT.gif?alt=media&token=5424fdf6-6695-4bd5-b154-0ae18b58c79e'),
          image: NetworkImage(document['url']),
          width: 250,
          height: 250,
        )
      ]
    );
  }
}
