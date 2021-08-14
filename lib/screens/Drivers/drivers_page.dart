import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_practice/models/driver.dart';

class DriversPage extends StatefulWidget {
  @override
  _DriversPageState createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> {
  Future getDriverData() async {
    var response =
        await http.get(Uri.http('ergast.com', 'api/f1/2020/drivers.json'));
    var decoded = jsonDecode(response.body);
    var jsonData = decoded["MRData"]["DriverTable"]["Drivers"];

    List<Driver> drivers = [];

    for (var driver in jsonData) {
      Driver c = Driver(
          driver['driverID'],
          driver['permanentNumber'],
          driver['code'],
          driver['url'],
          driver['givenName'],
          driver['familyName'],
          driver['dateOfBirth'],
          driver['nationality']);
      drivers.add(c);
    }
    return drivers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drivers in Formula One'),
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: getDriverData(),
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
                      title: Text(snapshot.data[i].givenName +
                          ' ' +
                          snapshot.data[i].familyName),
                      subtitle: Column(
                        children: [
                          Text('Permanent Number - ' +
                              snapshot.data[i].permanentNumber),
                          Text('Code - ' + snapshot.data[i].code),
                          Text('Date of Birth - ' +
                              snapshot.data[i].dateOfBirth),
                          Text('More info - ' + snapshot.data[i].url),
                        ],
                      ),
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
