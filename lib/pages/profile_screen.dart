import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_picture.png'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nombre: Juan Pérez',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Email: juan.perez@example.com',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 21),
            ElevatedButton(
              onPressed: () {},
              child: Text('Editar Perfil'),
            ),
            const SizedBox(height: 20),
          const Text(
              'Mis rutinas activas',
              
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
