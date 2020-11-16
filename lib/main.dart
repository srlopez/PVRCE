import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// ===========
  static const _itemCount = 10;
  int filas = 1;
  int columnas = 1;
  //var fflex = List<int>(_itemCount);
  //var cflex = List<List<int>>(_itemCount);
// ===========

  PageController _filasController;
  PageController _columnasController;

  @override
  void initState() {
    super.initState();
    _filasController = PageController();
    _columnasController = PageController();
    _filasController.addListener(() => _establecerFC());
    _columnasController.addListener(() => _establecerFC());

    //var rng = new Random();
    // for (var f = 0; f < _itemCount; f++) {
    //   fflex[f] = rng.nextInt(3) + 1;
    //   cflex[f] = [];
    //   for (var c = 0; c < _itemCount; c++) cflex[f].add(rng.nextInt(5) + 1);
    // }
  }

  _establecerFC() {
    setState(() {
      filas = _filasController.page.floor() + 1;
      columnas = _columnasController.page.floor() + 1;
      //print('$filas, $columnas');
    });
  }

  @override
  void dispose() {
    _filasController.dispose();
    _columnasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60,
              child: PageView.builder(
                controller: _filasController,
                itemBuilder: (context, page) {
                  return Center(child: MiText('${page + 1}'));
                },
                itemCount: _itemCount, // Can be null
              ),
            ),
            Divider(),
            SizedBox(
              height: 60,
              child: PageView.builder(
                controller: _columnasController,
                itemBuilder: (context, page) {
                  return Center(child: MiText('${page + 1}'));
                },
                itemCount: _itemCount, // Can be null
              ),
            ),
            Divider(),
            for (var f = 0; f < filas; f++)
              Expanded(
                //flex: fflex[f],
                child: Row(children: [
                  for (var c = 0; c < columnas; c++)
                    Expanded(
                      //flex: cflex[f][c],
                      //flex: Random().nextInt(3) + 1,<-- LOCURA
                      child: MiCaja(txt: '$f$c'),
                    )
                ]),
              ),
          ],
        ),
      ),
    );
  }
}

class MiCaja extends StatelessWidget {
  const MiCaja({
    Key key,
    @required this.txt,
  }) : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.blue, //                   <--- border color
            width: 1.0),
        //color: Colors.blue,
        borderRadius: BorderRadius.all(
            Radius.circular(3.0) //                 <--- border radius here
            ),
      ),
      child: Center(child: MiText(txt)),
    );
  }
}

class MiText extends StatelessWidget {
  const MiText(
    this.txt,
  );

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: GoogleFonts.lato(
          textStyle:
              TextStyle(color: Colors.blue, letterSpacing: .5, fontSize: 30)),
    );
  }
}
