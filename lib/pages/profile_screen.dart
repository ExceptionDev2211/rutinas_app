import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Necesario para usar File
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _imagePath;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    // Mostrar opciones al usuario para seleccionar la imagen
    final XFile? image = await showDialog<XFile?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar imagen'),
          content:
              const Text('¿Desea tomar una foto o seleccionar de la galería?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context,
                    await _picker.pickImage(source: ImageSource.camera));
              },
              child: const Text('Tomar Foto'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context,
                    await _picker.pickImage(source: ImageSource.gallery));
              },
              child: const Text('Seleccionar de la Galería'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar el diálogo sin seleccionar
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );

    if (image != null) {
      setState(() {
        _imagePath = image.path; // Actualiza la ruta de la imagen seleccionada
      });
    }
  }

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
            Center(
              child: GestureDetector(
                onTap:
                    _pickImage, // Permite cargar una imagen al tocar el círculo
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor:
                      Colors.grey, // Color de fondo en caso de no haber imagen
                  backgroundImage: _imagePath != null
                      ? FileImage(
                          File(_imagePath!)) // Muestra la imagen seleccionada
                      : const NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/2919/2919906.png'), // Ícono predeterminado
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
          ],
        ),
      ),
    );
  }
}
