import 'package:flutter/material.dart';

class CustomKeyboard extends StatefulWidget {
  final Function(String) onTextInput;
  final Function() onBackspace;
  final VoidCallback onEnter;

  const CustomKeyboard({
    Key? key,
    required this.onTextInput,
    required this.onBackspace,
    required this.onEnter,
  }) : super(key: key);

  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  bool _isNumeric = false;
  bool _isSpecial = false;
  bool _isUpperCase = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Ajusta la altura del teclado
      color: Colors.grey[200], // Color de fondo del teclado
      child: Column(
        children: [
          // Fila para los botones de cambio entre letras, números y caracteres especiales
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isSpecial = !_isSpecial;
                        if (_isSpecial) {
                          _isNumeric = false;
                        }
                      });
                    },
                    child: const Icon(Icons.star, size: 20),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      textStyle: const TextStyle(fontSize: 14),
                      backgroundColor: Colors.grey[300], // Color de fondo del botón
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isNumeric = !_isNumeric;
                        if (_isNumeric) {
                          _isSpecial = false;
                        }
                      });
                    },
                    child: Text(_isNumeric ? 'ABC' : '123'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      textStyle: const TextStyle(fontSize: 14),
                      backgroundColor: Colors.grey[300], // Color de fondo del botón
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isUpperCase = !_isUpperCase;
                      });
                    },
                    child: Icon(_isUpperCase ? Icons.keyboard_capslock : Icons.keyboard), // Cambiar icono basado en el estado
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      textStyle: const TextStyle(fontSize: 14),
                      backgroundColor: Colors.grey[300], // Color de fondo del botón
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 10,
              children: _getKeys(),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onBackspace,
                  child: const Icon(Icons.backspace, size: 20),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    textStyle: const TextStyle(fontSize: 14),
                    backgroundColor: Colors.grey[300], // Color de fondo del botón
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onEnter,
                  child: const Icon(Icons.arrow_forward, size: 20),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    textStyle: const TextStyle(fontSize: 14),
                    backgroundColor: Colors.grey[300], // Color de fondo del botón
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _getKeys() {
    final keys = <Widget>[];
    final letters = _isUpperCase ? 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' : 'abcdefghijklmnopqrstuvwxyz';

    if (_isNumeric) {
      for (var i = 0; i <= 9; i++) {
        keys.add(_buildKey(i.toString()));
      }
      keys.add(_buildKey('.'));
    } else if (_isSpecial) {
      // Puedes añadir caracteres especiales aquí
      const specialChars = ['!', '@', '#', '\$', '%', '^', '&', '*', '(', ')', '-', '=', '+'];
      for (var char in specialChars) {
        keys.add(_buildKey(char));
      }
    } else {
      for (var char in letters.split('')) {
        keys.add(_buildKey(char));
      }
      keys.add(_buildKey(' '));
    }

    return keys;
  }

  Widget _buildKey(String label) {
    return ElevatedButton(
      onPressed: () {
        widget.onTextInput(label);
      },
      child: Text(label),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(30, 30), 
        padding: const EdgeInsets.all(0),
        textStyle: const TextStyle(fontSize: 14),
        backgroundColor: Colors.grey[300], // Color de fondo del botón
      ),
    );
  }
}
