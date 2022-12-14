import 'package:aula_flutter_2/models/planet.dart';
import 'package:aula_flutter_2/services/moon_repository.dart';
import 'package:flutter/material.dart';

class MoonsPage extends StatefulWidget {
  const MoonsPage({super.key, required this.planet});

  final Planet planet;

  @override
  State<MoonsPage> createState() => _MoonsPageState();
}

class _MoonsPageState extends State<MoonsPage> {
  final TextEditingController _controller = TextEditingController();

  Future<List<String>> getMoons() async {
    return await moonRepository.get(widget.planet.id.toString());
  }

  Future<void> addMoon() async {
    if (_controller.text.isNotEmpty) {
      await moonRepository.add(widget.planet.id.toString(), _controller.text);
      setState(() {
        _controller.text = '';
      });
    }
  }

  Future<void> removeMoon(String moon) async {
    await moonRepository.remove(widget.planet.id.toString(), moon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moons of ${widget.planet.name}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              enableSuggestions: false,
              controller: _controller,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Type the moon's name"
              ),
            ),
            TextButton(
              onPressed: addMoon,
              child: const Text('Add a new Moon'),
            ),
            Expanded(
              child: FutureBuilder(
                future: getMoons(),
                builder: (context, AsyncSnapshot<List<String>> snapshot) {
                  final List<String> moons = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: moons.length,
                    itemBuilder: (context, index) {
                      return _buildItem(context, moons[index]);
                    }
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String moon) {
    return Dismissible(
      key: ValueKey<String>(moon),
      background: Container(
        color: Colors.red,
        alignment: Alignment.center,
        child: const Text('delete', style: TextStyle(fontSize: 28),),
      ),
      onDismissed: (direction) {
        removeMoon(moon);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$moon moon was deleted!"))
        );
      },
      child: ListTile(
        title: Text(moon),
      ),
    );
  }

}