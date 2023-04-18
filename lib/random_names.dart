import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

class RandomNames extends StatefulWidget {
  const RandomNames({super.key});

  @override
  RandomNamesState createState() {
    return RandomNamesState();
  }
}

class RandomNamesState extends State<RandomNames> {
  final _randomNames = List.generate(500, (index) => faker.person.name());
  final _savedNames = <String>{};

  Widget _listBuilder() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        final name = _randomNames[index];
        final isSaved = _savedNames.contains(name);
        return ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 144, 131, 156),
              child: Text('${index + 1}'),
            ),
            title: Text(name),
            onTap: () {
              setState(() {
                if (isSaved) {
                  _savedNames.remove(name);
                } else {
                  _savedNames.add(name);
                }
              });
            },
            trailing: Icon(isSaved ? Icons.favorite : Icons.favorite_border,
                color:
                    isSaved ? const Color.fromARGB(255, 144, 131, 156) : null));
      },
      itemCount: _randomNames.length,
    );
  }

  // ignore: no_leading_underscores_for_local_identifiers
  void _pushPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
      final Iterable<ListTile> tiles =
          _savedNames.map((name) => ListTile(title: Text(name)));
      final List<Widget> divided =
          ListTile.divideTiles(tiles: tiles, context: context).toList();

      return Scaffold(
        appBar: AppBar(title: const Text('Saved Names')),
        body: ListView(children: divided),
      );
    })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Names'), actions: <Widget>[
        IconButton(
            icon: const Icon(Icons.list), onPressed: () => _pushPage(context))
      ]),
      body: _listBuilder(),
    );
  }
}
