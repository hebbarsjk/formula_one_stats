// import 'package:api_practice/screens/Home/home_page.dart';
// import 'package:api_practice/screens/Standings/standings_page.dart';
// import 'package:api_practice/screens/Drivers/drivers_page.dart';
import 'package:api_practice/screens/Authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Future<FirebaseApp> _intialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _intialization,
      builder: (context, snapshot) {
        // checking for errors
        if (snapshot.hasError) {
          print('Error');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return LogIn();
        }
        return CircularProgressIndicator();
      },
    );
  }
}










// Scaffold(
//       appBar: AppBar(
//         title: Text('Formula One Stats'),
//       ),
//       body: DefaultTabController(
//         length: 3,
//         child: Stack(
//           children: [
//             Container(
//               height: double.infinity,
//               width: double.infinity,
//             ),
//             Scaffold(
//               bottomNavigationBar: Padding(
//                 padding: EdgeInsets.only(bottom: 15.0),
//                 child: TabBar(
//                   tabs: [
//                     Tab(
//                       icon: Icon(Icons.circle),
//                     ),
//                     Tab(
//                       icon: Icon(Icons.play_arrow),
//                     ),
//                     Tab(
//                       icon: Icon(Icons.person),
//                     ),
//                   ],
//                   labelColor: Colors.red,
//                   indicator: UnderlineTabIndicator(
//                     borderSide: BorderSide(color: Colors.red, width: 4.0),
//                     insets: EdgeInsets.only(bottom: 44),
//                   ),
//                   unselectedLabelColor: Colors.grey,
//                 ),
//               ),
//               body: TabBarView(
//                 children: [
//                   HomePage(),
//                   StandingsPage(),
//                   DriversPage(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );