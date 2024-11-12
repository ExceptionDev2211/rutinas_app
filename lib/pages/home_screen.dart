import 'package:flutter/material.dart';
import 'package:rutinas_app/pages/location_screen.dart';
import '../widgets/routine_card.dart';
import 'profile_screen.dart';
import 'road.dart';
import 'routines_screen.dart';
import 'calendar_screen.dart';
import '../utils/page_animation_routes.dart';

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
              description: 'Rutina para fortalecer y definir el abdomen. Incluye crunches, elevaciones de piernas y planchas.',
              imagePath: 'assets/images/abdominales.jpg',
              onTap: () {
                Navigator.push(
                  context,
                  PageAnimationRoutes(
                    widget: const RutinesPage(routineName: 'Abdominales'),
                    ejex: 0,
                    ejey: -0.4,
                  ),
                );
              },
            ),
            const SizedBox(height: 16), 
            RoutineCard(
              title: 'Brazos',
              description: 'Entrenamiento para tonificar los músculos de los brazos. Ejercicios incluyen flexiones, bíceps con mancuernas y tríceps en banco.',
              imagePath: 'assets/images/brazo.jpg',
              onTap: () {
                Navigator.push(
                  context,
                  PageAnimationRoutes(
                    widget: const RutinesPage(routineName: 'Brazos'),
                    ejex: 0,
                    ejey: -0.2,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            RoutineCard(
              title: 'Piernas',
              description: 'Rutina para fortalecer y esculpir las piernas. Incluye sentadillas, lunges y extensiones de piernas.',
              imagePath: 'assets/images/piernas.jpg',
              onTap: () {
                Navigator.push(
                  context,
                  PageAnimationRoutes(
                    widget: const RutinesPage(routineName: 'Piernas'),
                    ejex: 0,
                    ejey: 0,
                  ),
                );
              },
            ),
            const SizedBox(height: 16), 
            RoutineCard(
              title: 'Hombros',
              description: 'Ejercicios para desarrollar los músculos del hombro. Incluye press de hombros, elevaciones laterales y frontales.',
              imagePath: 'assets/images/hombros.jpg',
              onTap: () {
                Navigator.push(
                  context,
                  PageAnimationRoutes(
                    widget: const RutinesPage(routineName: 'Hombros'),
                    ejex: 0,
                    ejey: 0.2,
                  ),
                );
              },
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
            icon: Icon(Icons.download),
            label: 'Rutas',
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
                MaterialPageRoute(builder: (context) => const Road()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalendarScreen()),
              );
              break;
            case 3:
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
