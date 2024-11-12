import 'package:flutter/material.dart';
import 'package:rutinas_app/models/db_model.dart';
import 'package:rutinas_app/providers/db_features.dart';

class RutinesPage extends StatefulWidget {
  final String routineName;

  const RutinesPage({super.key, required this.routineName});

  @override
  _RutinesPageState createState() => _RutinesPageState();
}

class _RutinesPageState extends State<RutinesPage> {
  final DBEFeatures db = DBEFeatures();
  List<Routine> customRoutines = [];
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedDifficulty = 'Principiante';

  @override
  void initState() {
    super.initState();
    _loadCustomRoutines();
  }

  Future<void> _loadCustomRoutines() async {
    List<Routine> dbRoutines = await db.getAllRoutines();
    setState(() {
      customRoutines = dbRoutines;
    });
  }

  Future<void> _addCustomRoutine() async {
    final newRoutine = Routine(
      title: titleController.text,
      description: descriptionController.text,
      type: widget.routineName,
      difficulty: selectedDifficulty,
    );

    await db.insertRoutine(newRoutine);
    titleController.clear();
    descriptionController.clear();
    selectedDifficulty = 'Principiante';
    _loadCustomRoutines();
  }

  Future<void> _deleteCustomRoutine(int id) async {
    await db.deleteRoutine(id);
    _loadCustomRoutines();
  }

  List<Routine> _getPredefinedRoutines(String difficulty) {
    switch (difficulty) {
      case 'Principiante':
        return [
          Routine(
            title: 'Elevación de Piernas',
            description: 'Acuéstate en el suelo y eleva las piernas rectas.',
            type: widget.routineName,
            difficulty: 'Principiante',
          ),
          Routine(
            title: 'Crunches',
            description: 'Acuéstate sobre la espalda con las piernas flexionadas y eleva el torso hacia las rodillas.',
            type: widget.routineName,
            difficulty: 'Principiante',
          ),
        ];
      case 'Intermedio':
        return [
          Routine(
            title: 'Elevación de Piernas',
            description: 'Acuéstate en el suelo y eleva las piernas rectas.',
            type: widget.routineName,
            difficulty: 'Intermedio',
          ),
          Routine(
            title: 'Tablón',
            description: 'Mantén una posición de plancha con los codos y pies en el suelo.',
            type: widget.routineName,
            difficulty: 'Intermedio',
          ),
          Routine(
            title: 'Crunches con Giro',
            description: 'Realiza crunches mientras giras el torso hacia los lados.',
            type: widget.routineName,
            difficulty: 'Intermedio',
          ),
        ];
      case 'Avanzado':
        return [
          Routine(
            title: 'Elevación de Piernas con Pesas',
            description: 'Acuéstate en el suelo y eleva las piernas con pesas en los tobillos.',
            type: widget.routineName,
            difficulty: 'Avanzado',
          ),
          Routine(
            title: 'Tablón con Elevación de Piernas',
            description: 'Mantén una posición de plancha y eleva una pierna a la vez.',
            type: widget.routineName,
            difficulty: 'Avanzado',
          ),
          Routine(
            title: 'Crunches con Peso',
            description: 'Realiza crunches mientras sostienes un peso sobre el pecho.',
            type: widget.routineName,
            difficulty: 'Avanzado',
          ),
        ];
      default:
        return [];
    }
  }

  List<Routine> _getAllRoutines(String difficulty) {
    return [
      ..._getPredefinedRoutines(difficulty),
      ...customRoutines.where((routine) => routine.difficulty == difficulty && routine.type == widget.routineName),
    ];
  }

  Widget _buildExerciseList(List<Routine> exercises) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: exercises.map((exercise) {
        bool isPredefined = _getPredefinedRoutines(exercise.difficulty).any((predefined) => predefined.title == exercise.title);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(exercise.title),
            subtitle: Text(exercise.description),
            trailing: isPredefined 
                ? null 
                : IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteCustomRoutine(exercise.id!);
                    },
                  ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.routineName),
          backgroundColor: Colors.blueAccent,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Principiante'),
              Tab(text: 'Intermedio'),
              Tab(text: 'Avanzado'),
            ],
          ),
        ),
        body: SingleChildScrollView( 
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Agregar Rutina Personalizada',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: titleController,
                        decoration: const InputDecoration(hintText: 'Título de la rutina'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(hintText: 'Descripción de la rutina'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedDifficulty,
                        items: <String>['Principiante', 'Intermedio', 'Avanzado']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDifficulty = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton( 
                onPressed: _addCustomRoutine,
                child: const Text('Agregar'),
              ),
              const SizedBox(height: 16),
              
              SizedBox(
                height: 400,
                child: TabBarView(
                  children: [
                    _buildExerciseList(_getAllRoutines('Principiante')),
                    _buildExerciseList(_getAllRoutines('Intermedio')),
                    _buildExerciseList(_getAllRoutines('Avanzado')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
