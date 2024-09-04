// pages/rutines_page.dart
import 'package:flutter/material.dart';

class RutinesPage extends StatelessWidget {
  final String routineName;

  const RutinesPage({super.key, required this.routineName});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          title: Text(routineName),
          backgroundColor: Colors.blueAccent,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Principiante'),
              Tab(text: 'Intermedio'),
              Tab(text: 'Avanzado'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildExerciseList(_getExercisesForLevel('Principiante')),
            _buildExerciseList(_getExercisesForLevel('Intermedio')),
            _buildExerciseList(_getExercisesForLevel('Avanzado')),
          ],
        ),
      ),
    );
  }

  List<Map<String, String>> _getExercisesForLevel(String level) {
    switch (routineName) {
      case 'Abdominales':
        switch (level) {
          case 'Principiante':
            return [
              {
                'name': 'Elevación de Piernas',
                'description': 'Acuéstate en el suelo y eleva las piernas rectas.'
              },
              {
                'name': 'Crunches',
                'description': 'Acuéstate sobre la espalda con las piernas flexionadas y eleva el torso hacia las rodillas.'
              },
            ];
          case 'Intermedio':
            return [
              {
                'name': 'Elevación de Piernas',
                'description': 'Acuéstate en el suelo y eleva las piernas rectas.'
              },
              {
                'name': 'Tablón',
                'description': 'Mantén una posición de plancha con los codos y pies en el suelo.'
              },
              {
                'name': 'Crunches con Giro',
                'description': 'Realiza crunches mientras giras el torso hacia los lados.'
              },
            ];
          case 'Avanzado':
            return [
              {
                'name': 'Elevación de Piernas con Pesas',
                'description': 'Acuéstate en el suelo y eleva las piernas con pesas en los tobillos.'
              },
              {
                'name': 'Tablón con Elevación de Piernas',
                'description': 'Mantén una posición de plancha y eleva una pierna a la vez.'
              },
              {
                'name': 'Crunches con Peso',
                'description': 'Realiza crunches mientras sostienes un peso sobre el pecho.'
              },
            ];
        }
        break;
      case 'Brazos':
        
        break;
      case 'Piernas':
        
        break;
      case 'Hombros':
        
        break;
      default:
        return [];
    }
    return [];
  }

  Widget _buildExerciseList(List<Map<String, String>> exercises) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: exercises.map((exercise) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(exercise['name']!),
            subtitle: Text(exercise['description']!),
          ),
        );
      }).toList(),
    );
  }
}
