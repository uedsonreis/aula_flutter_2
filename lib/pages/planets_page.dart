import 'package:aula_flutter_2/components/planet_item.dart';
import 'package:aula_flutter_2/models/planet.dart';
import 'package:aula_flutter_2/services/planet_service.dart';
import 'package:flutter/material.dart';

class PlanetsPage extends StatefulWidget {
  const PlanetsPage({super.key});

  final String title = "Solar System Planets";

  @override
  State<PlanetsPage> createState() => _PlanetsPageState();
}

class _PlanetsPageState extends State<PlanetsPage> {

  Future<List<Planet>> fetchPlanets() async {
    PlanetService service = PlanetService();
    return await service.getPlanets();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPlanets(),
      builder: (context, AsyncSnapshot<List<Planet>> snapshot) {
        final List<Planet> planets = snapshot.data ?? [];

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: ListView.builder(
            itemCount: planets.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  PlanetItem(planet: planets[index]),
                  const Divider()
                ],
              );
            }
          )
        );
      }
    );
  }
}