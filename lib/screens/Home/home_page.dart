import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_practice/models/circuit.dart';
import 'package:api_practice/screens/locate_circuit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getCircuitData() async {
    var response =
        await http.get(Uri.http('ergast.com', 'api/f1/circuits.json'));
    var decoded = jsonDecode(response.body);
    var jsonData = decoded["MRData"]["CircuitTable"]["Circuits"];

    List<Circuit> circuits = [];

    for (var circuit in jsonData) {
      print("Circuit");
      Circuit c = Circuit(
          circuit['circuitId'],
          circuit['url'],
          circuit['circuitName'],
          circuit['Location']['lat'],
          circuit['Location']['long'],
          circuit['Location']['locality'],
          circuit['Location']['country']);
      circuits.add(c);
    }
    return circuits;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circuits in Formula One'),
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: getCircuitData(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text('Loading...'),
                  ),
                );
              } else
                return ListView.separated(
                  padding: EdgeInsets.all(8.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(snapshot.data[i].circuitName),
                      subtitle: Column(
                        children: [
                          Text('City - ' + snapshot.data[i].locality),
                          Text('Country - ' + snapshot.data[i].country),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocateCircuit(
                                    double.parse(snapshot.data[i].lat),
                                    double.parse(snapshot.data[i].long))));
                      },
                    );
                  },
                  separatorBuilder: (context, i) => Divider(),
                );
            },
          ),
        ),
      ),
    );
  }
}