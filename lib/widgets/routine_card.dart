// widgets/routine_card.dart
import 'package:flutter/material.dart';

class RoutineCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  

  const RoutineCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
        
      ),
    );
  }
}
