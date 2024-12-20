import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; 
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _imagePath;
  final List<String> _activeRoutines = []; 

  void _addRoutine(String routine) {
    setState(() {
      _activeRoutines.add(routine); 
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    
    final XFile? image = await showDialog<XFile?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar imagen'),
          content: const Text('¿Desea tomar una foto o seleccionar de la galería?'),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
                  Navigator.pop(context, pickedImage);
                } catch (e) {
                  Navigator.pop(context, null);
                  _showError(context, 'Error al acceder a la cámara.');
                }
              },
              child: const Text('Tomar Foto'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
                  Navigator.pop(context, pickedImage);
                } catch (e) {
                  Navigator.pop(context, null);
                  _showError(context, 'Error al acceder a la galería.');
                }
              },
              child: const Text('Seleccionar de la Galería'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );

    
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: GestureDetector(
                onTap: _pickImage, 
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey,
                  backgroundImage: _imagePath != null
                      ? FileImage(File(_imagePath!))
                      : const NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/2919/2919906.png') as ImageProvider,
                ),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfile()),
                );
              },
              child: const Text('Editar Perfil'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Mis rutinas activas',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _activeRoutines.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_activeRoutines[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoutineDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Function(String) onActivateRoutine;

  const RoutineDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onActivateRoutine,
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onActivateRoutine(title);
                Navigator.pop(context);
              },
              child: const Text('Activar rutina'),
            ),
          ],
        ),
      ),
    );
  }
}
