import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _counter = 0.0;
  var myFontSize = 30.0;

  void setNewValue(double value) {
    setState(() {
      _counter = value;
      myFontSize = value > 60.0 ? 60.0 : (value < 10.0 ? 10.0 : value);
    });
  }

  void _incrementCounter() {
    setState(() {
      if (_counter < 100.0) {
        _counter = (_counter + 1).clamp(0.0, 100.0);
        myFontSize = (myFontSize + 1.0).clamp(10.0, 60.0);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:',
                style:TextStyle( fontSize:myFontSize )),
            Text('$_counter', style: TextStyle(fontSize: myFontSize)),
            Slider(value:_counter,
              min: 0.0,
              max: 100.0,
              onChanged: setNewValue,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
