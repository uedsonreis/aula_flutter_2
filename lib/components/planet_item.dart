import 'package:aula_flutter_2/models/planet.dart';
import 'package:aula_flutter_2/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlanetItem extends StatelessWidget {
  const PlanetItem({super.key, required this.planet});

  final Planet planet;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(planet.name, style: const TextStyle(fontSize: 18)),
      subtitle: Text(
        "${planet.id.toString()}º planet",
        textAlign: TextAlign.right
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailPage(planet: planet))
      )
    );
  }
}