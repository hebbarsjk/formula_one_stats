import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:api_practice/models/standing.dart';

class StandingsPage extends StatefulWidget {
  @override
  _StandingsPageState createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  Future getStandingData() async {
    var response = await http
        .get(Uri.http('ergast.com', 'api/f1/2020/driverStandings.json'));
    var decoded = jsonDecode(response.body);
    var jsonData =
        decoded["MRData"]["StandingsTable"]["StandingsList"]["DriverStandings"];

    List<Standing> standings = [];

    for (var standing in jsonData) {
      print("Circuit");
      Standing c = Standing(
          standing['position'],
          standing['points'],
          standing['wins'],
          standing['Driver']['driverID'],
          standing['Driver']['permanentNumber'],
          standing['Driver']['code'],
          standing['Driver']['givenName'],
          standing['Driver']['lastName'],
          standing['Driver']['dateOfBirth'],
          standing['Driver']['nationality']);
      standings.add(c);
    }
    return standings;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
