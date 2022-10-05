import 'package:flutter/material.dart';
import 'package:cron/cron.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

const ow2Logo = "./assets/ow2_logo.png";
const loadingGif = "./assets/loading_gif.gif";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Overwatch 2 Experience',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Overwatch 2'),
    );
  }
}

double displayHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double displayWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<String> searchingMsg = [
    "SEARCHING FOR GAME SERVER...",
    "IN QUEUE: 0 PLAYERS AHEAD OF YOU",
    "IN QUEUE: 100 PLAYERS AHEAD OF YOU",
    "IN QUEUE: 300 PLAYERS AHEAD OF YOU",
    "IN QUEUE: 600 PLAYERS AHEAD OF YOU",
    "IN QUEUE: 900 PLAYERS AHEAD OF YOU",
    "IN QUEUE: 1000 PLAYERS AHEAD OF YOU",
    "IN QUEUE: 9000 PLAYERS AHEAD OF YOU",
    "IN QUEUE: 10000 PLAYERS AHEAD OF YOU",
    "IN QUEUE: 20000 PLAYERS AHEAD OF YOU",
    "IN QUEUE: 30000 PLAYERS AHEAD OF YOU",
    "IN QUEUE: 40000 PLAYERS AHEAD OF YOU",
  ];

  String activeMsg = searchingMsg.elementAt(0);

  String btn1 = "MANAGE ACCOUNT";
  String btn2 = "EXIT TO DESKTOP";
  static String oldMsg = "THIS IS NOT MINING BITCOIN. DO NOT WORRY";
  static String newMsg = "YOU CANNOT LEAVE AT THIS TIME";
  String botMsg = oldMsg;

  void _changeWaitingMsg() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      //searchingMsg++;
      var rng = Random();
      var newMsg = rng.nextInt(6);
      activeMsg = searchingMsg.elementAt(newMsg);
      botMsg = oldMsg;
    });
  }

  void _warnUser() {
    setState(() {
      botMsg = newMsg;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cron = new Cron();
    cron.schedule(new Schedule.parse('*/1 * * * *'), () async {
      //print('every one minutes');
      _changeWaitingMsg();
    });
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color.fromARGB(255, 255, 232, 189),
              Color.fromARGB(255, 232, 245, 255),
              Color.fromARGB(255, 232, 245, 255),
              Color.fromARGB(255, 232, 245, 255),
              Color.fromARGB(255, 207, 221, 230),
              Color.fromARGB(255, 168, 184, 196),
            ])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth < 400) {
                return _buildTinyMobileContainer(context);
              }
              if (constraints.maxWidth < 600) {
                return _buildMobileContainer(context);
              } else {
                return _buildNormalWebContainer(context);
              }
            })));
  }

  Widget _buildNormalWebContainer(context) {
    return SingleChildScrollView(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  '2.1.0.1 - 105964',
                  style: GoogleFonts.lato(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 45, 45, 45)),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Image.asset(
              ow2Logo,
              height: 300,
              width: 600,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Image.asset(
                      loadingGif,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  Text(
                    '$activeMsg',
                    style: GoogleFonts.overpass(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 45, 45, 45)),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
                ),
                onPressed: () => _warnUser(),
                child: const Text(
                  "CANCEL",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
          ),
          SizedBox(
            child: Center(),
            height: displayHeight(context) / 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 10),
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 32),
                          ),
                          onPressed: () {},
                          child: Text(
                            "$btn1",
                            style: GoogleFonts.lato(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 10),
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 32),
                          ),
                          onPressed: () {},
                          child: Text(
                            "$btn2",
                            style: GoogleFonts.lato(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Text(
                '$botMsg',
                style: GoogleFonts.lato(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 45, 45, 45)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileContainer(context) {
    return SingleChildScrollView(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  '2.1.0.1 - 105964',
                  style: GoogleFonts.lato(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 45, 45, 45)),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Image.asset(
              ow2Logo,
              height: 200,
              width: 400,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Image.asset(
                      loadingGif,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  Text(
                    '$activeMsg',
                    style: GoogleFonts.overpass(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 45, 45, 45)),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
                ),
                onPressed: () => _warnUser(),
                child: const Text(
                  "CANCEL",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
          ),
          SizedBox(
            child: Center(),
            height: displayHeight(context) / 3,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Text(
                '$botMsg',
                style: GoogleFonts.lato(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 45, 45, 45)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTinyMobileContainer(context) {
    return SingleChildScrollView(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  '2.1.0.1 - 105964',
                  style: GoogleFonts.lato(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 45, 45, 45)),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Image.asset(
              ow2Logo,
              height: 150,
              width: 300,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Image.asset(
                      loadingGif,
                      height: 18,
                      width: 18,
                    ),
                  ),
                  Text(
                    '$activeMsg',
                    style: GoogleFonts.overpass(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 45, 45, 45)),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                ),
                onPressed: () => _warnUser(),
                child: const Text(
                  "CANCEL",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
          ),
          SizedBox(
            child: Center(),
            height: displayHeight(context) / 3,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Text(
                '$botMsg',
                style: GoogleFonts.lato(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 45, 45, 45)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
