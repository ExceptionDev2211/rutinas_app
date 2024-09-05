import 'package:flutter/material.dart';
import 'package:rutinas_app/pages/calendar_screen.dart';
import '../widgets/routine_card.dart';
import 'profile_screen.dart';
import 'routines_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutinas en casa'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[100],
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            RoutineCard(
              title: 'Abdominales',
              description:
                  'Rutina para fortalecer y definir el abdomen. Incluye crunches, elevaciones de piernas y planchas.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const RutinesPage(routineName: 'Abdominales'),
                  ),
                );
              },
              //imagePath: "rutinas_app/lib/images/brazo.png",
            ),
            RoutineCard(
              title: 'Brazos',
              description:
                  'Entrenamiento para tonificar los músculos de los brazos. Ejercicios incluyen flexiones, bíceps con mancuernas y tríceps en banco.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const RutinesPage(routineName: 'Brazos'),
                  ),
                );
              }, 
              //imagePath: "rutinas_app/lib/images/brazo.png",
            ),
            RoutineCard(
              title: 'Piernas',
              description:
                  'Rutina para fortalecer y esculpir las piernas. Incluye sentadillas, lunges y extensiones de piernas.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const RutinesPage(routineName: 'Piernas'),
                  ),
                );
              },
              //imagePath: "rutinas_app/lib/images/brazo.png",
            ),
            RoutineCard(
              title: 'Hombros',
              description:
                  'Ejercicios para desarrollar los músculos del hombro. Incluye press de hombros, elevaciones laterales y frontales.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const RutinesPage(routineName: 'Hombros'),
                  ),
                );
              }, 
              //imagePath: "rutinas_app/lib/images/brazo.png",
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Rutinas',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 10,
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalendarScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}
