import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(const MyApp());
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[];

  void getNext() 
  {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite()
  {
    if (favorites.contains(current)) 
    {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }

    notifyListeners();
  }

  void removeFavorite(favorite)
  {
    favorites.remove(favorite);
    notifyListeners();
  }

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "My First App",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)
        ),
        home: HomePage(),
      ),
    );
  }
}


// ...

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritePage();
        break;
      default:
        throw UnimplementedError("Apalah");
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favorites = appState.favorites;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          for (var favorite in favorites)
            Card(
              child: ListTile(
                leading: const Icon(Icons.favorite),
                title: Text("${favorite.first} ${favorite.second}"),
                onTap: () {
                  appState.removeFavorite(favorite);
                },
              ),
            ),
          
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );

    return Card(
      color: theme.colorScheme.primary,
      elevation: 30.0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text("${pair.first} ${pair.second}", style: style,),
      ),
    );
  }
}




