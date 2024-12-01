
import 'package:flutter/material.dart';

class RoutineCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  final String imagePath; 

  const RoutineCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    required this.imagePath, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.5), 
            ),
          ),
          
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
