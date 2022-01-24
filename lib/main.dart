import 'package:covid_live/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19',
      theme: ThemeData(
          brightness: Brightness.dark,
          textTheme: TextTheme(
            headline1: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
            headline2: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 20.0,
            ),
          ),
      ),
      home: startScreen(),
    );
  }
}

class startScreen extends StatelessWidget {
  const startScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 7,child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/covidimage.jpg"),
                fit: BoxFit.cover,
              )
             ),
            ),),
          Expanded(
            child: Column(
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                      TextSpan(text: "COVID-19\n", style: Theme.of(context).textTheme.headline1,),
                      TextSpan(text: "Stay Home! Stay Safe!", style: Theme.of(context).textTheme.headline2,),
                    ]
                  ),
                ),
              ],

            ),
          ),
          FittedBox(
            child: GestureDetector(
              onTap: (){
                //print('Hi');
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return DashBoard();
                }));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),color: Colors.cyan),
                child: Row(
                  children: <Widget>[
                    Text('View Details'),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}

