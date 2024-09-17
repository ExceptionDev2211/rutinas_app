import 'package:flutter/material.dart';
import 'package:rutinas_app/widgets/custom_keyboard.dart'; // Asegúrate de que la ruta al archivo sea correcta

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  
  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();
  final FocusNode _weightFocusNode = FocusNode();
  final FocusNode _heightFocusNode = FocusNode();
  final FocusNode _contactNumberFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _fullNameFocusNode.addListener(() {
      if (_fullNameFocusNode.hasFocus) {
        _showCustomKeyboard(_fullNameController);
      }
    });

    _ageFocusNode.addListener(() {
      if (_ageFocusNode.hasFocus) {
        _showCustomKeyboard(_ageController);
      }
    });

    _weightFocusNode.addListener(() {
      if (_weightFocusNode.hasFocus) {
        _showCustomKeyboard(_weightController);
      }
    });

    _heightFocusNode.addListener(() {
      if (_heightFocusNode.hasFocus) {
        _showCustomKeyboard(_heightController);
      }
    });

    _contactNumberFocusNode.addListener(() {
      if (_contactNumberFocusNode.hasFocus) {
        _showCustomKeyboard(_contactNumberController);
      }
    });
  }

  void _showCustomKeyboard(TextEditingController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Asegúrate de que el tamaño del teclado se ajuste
      builder: (context) {
        return CustomKeyboard(
          onTextInput: (text) {
            final newText = controller.text + text;
            controller.text = newText;
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
          },
          onBackspace: () {
            final text = controller.text;
            if (text.isNotEmpty) {
              controller.text = text.substring(0, text.length - 1);
              controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length),
              );
            }
          },
          onEnter: () {
            Navigator.of(context).pop(); // Cierra el teclado (BottomSheet)
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Gym Profile'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _fullNameController,
                focusNode: _fullNameFocusNode,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _ageController,
                focusNode: _ageFocusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _weightController,
                focusNode: _weightFocusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.fitness_center),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _heightController,
                focusNode: _heightFocusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.height),
                ),
              ),
              const SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Training Goal',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag),
                ),
                items: const [
                  DropdownMenuItem(value: 'Lose Weight', child: Text('Lose Weight')),
                  DropdownMenuItem(value: 'Build Muscle', child: Text('Build Muscle')),
                  DropdownMenuItem(value: 'Increase Strength', child: Text('Increase Strength')),
                  DropdownMenuItem(value: 'Improve Endurance', child: Text('Improve Endurance')),
                ],
                onChanged: (value) {
                  // Manejar la selección del objetivo de entrenamiento
                },
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _contactNumberController,
                focusNode: _contactNumberFocusNode,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  // Acción para guardar los cambios del perfil
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gym Profile updated')),
                  );
                },
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
