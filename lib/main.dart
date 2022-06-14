// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      // theme: ThemeData(

      //   primarySwatch: Colors.blue,
      // ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),

      title: 'welcome first flutter app of mine',
      home: const RandomWords(),
      theme: ThemeData(
        // Add the 5 lines from here...
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ), // ... to here.
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text('cai app nay delay qua'),
      //   ),
      //   body: RandomWords(),
      //   // body: MyHomePage(
      //   //   title: 'welcome first app liem',
      //   // ),
      // ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  // @override
  // Widget build(BuildContext context) {
  //   final wordPair = WordPair.random();
  //   final _suggestions = <WordPair>[];
  //   final _biggerFont = const TextStyle(fontSize: 16);
  //   // return Text(wordPair.asPascalCase);
  //   return ListView.builder(
  //     padding: const EdgeInsets.all(16.0),
  //     itemBuilder: /*1*/ (context, i) {
  //       if (i.isOdd) return const Divider(); /*2*/

  //       final index = i ~/ 2; /*3*/
  //       if (index >= _suggestions.length) {
  //         _suggestions.addAll(generateWordPairs().take(10)); /*4*/
  //       }
  //       // return Text(_suggestions[index].asPascalCase);
  //       return ListTile(
  //         title: Text(
  //           _suggestions[index].asPascalCase,
  //           style: _biggerFont,
  //         ),
  //       );
  //     },
  //   );
  // }
  final wordPair = WordPair.random();
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 16);
  final _saved = <WordPair>{}; // NEW

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Flutter App of Mine'),
        actions: [
          IconButton(
            onPressed: _pushSaved,
            icon: const Icon(Icons.list),
            tooltip: 'Saved',
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }

          final alreadySaved = _saved.contains(_suggestions[index]); // NEW

          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            leading: Image.asset('images/icon_songoku.png'),
            trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: () {
              setState((() {
                if (alreadySaved) {
                  _saved.remove(_suggestions[index]);
                } else {
                  _saved.add(_suggestions[index]);
                }
              }));
            },
          );
        },
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RandomWords(),
        // child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // children: <Widget>[
        //   Text('cái nay random word'),
        //   const RandomWords(), //freeze
        //   RandomWords(),
        //   Text(
        //     '$_counter',
        //     style: Theme.of(context).textTheme.headline4,
        //   ),
        // ],
        // ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
