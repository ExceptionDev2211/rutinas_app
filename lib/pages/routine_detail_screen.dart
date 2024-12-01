import 'package:flutter/material.dart';

class RoutineDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Function? onActivate; 

  const RoutineDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.onActivate, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (onActivate != null) {
                    onActivate!(); 
                  }
                  Navigator.pop(context); 
                },
                child: const Text('Activar Rutina'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
