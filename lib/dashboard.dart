import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'package:intl/intl.dart';


Future<Covid> fetchCovidData() async {
  final response = await http
      .get( Uri.parse('https://corona.lmao.ninja/v2/countries/india?yesterday=false'));
  if(response.statusCode == 200){
    return Covid.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load Covid Data!');
  }
}

class Covid{
  final int totcases;
  final int deaths;
  final int recovered;
  final int active;
  final int updated;
  final String country;

  Covid({required this.totcases,required this.deaths,required this.recovered,required this.active, required this.updated, required this.country});

  factory Covid.fromJson(Map<String, dynamic> json){
    return Covid(
      totcases: json['cases'],
      deaths: json['deaths'],
      recovered: json['recovered'],
      active: json['active'],
      updated: json['updated'],
      country: json['country']
    );
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late Future<Covid> futureCovid;
  @override
  void initState() {
    futureCovid = fetchCovidData();
    super.initState();
  }

  String _dateValue(int timeInMillis){
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    var formattedDate = DateFormat("dd-MM-yyyy hh:mm:ss").format(date);
    return formattedDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Covid>(
        future: futureCovid,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/india2.jpg"),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter
                      )
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Country : ', style: TextStyle(fontSize: 25.0, color: Colors.amberAccent,),),
                          Text(snapshot.data!.country, style: TextStyle(fontSize: 25.0, color: Colors.cyan,),),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Cases : ', style: TextStyle(fontSize: 25.0, color: Colors.blueAccent,),),
                          Text(snapshot.data!.totcases.toString(), style: TextStyle(fontSize: 22.0, color: Colors.white,),),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Deaths : ', style: TextStyle(fontSize: 25.0, color: Colors.red,),),
                          Text(snapshot.data!.deaths.toString(), style: TextStyle(fontSize: 22.0, color: Colors.white,),),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Recovered : ', style: TextStyle(fontSize: 25.0, color: Colors.green,),),
                          Text(snapshot.data!.recovered.toString(), style: TextStyle(fontSize: 22.0, color: Colors.white,),),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Active Cases : ', style: TextStyle(fontSize: 25.0, color: Colors.orange,),),
                          Text(snapshot.data!.active.toString(), style: TextStyle(fontSize: 22.0, color: Colors.white,),),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text('Last Update: ${_dateValue(snapshot.data!.updated)}'),
                        ],
                      ),
                    ),
                  ),
                )
            ],);
          } else if(snapshot.hasError){
            return Text('${snapshot.hasError}');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
