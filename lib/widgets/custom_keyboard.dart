import 'package:flutter/material.dart';

class CustomKeyboard extends StatefulWidget {
  final Function(String) onTextInput;
  final Function() onBackspace;
  final VoidCallback onEnter;

  const CustomKeyboard({
    super.key,
    required this.onTextInput,
    required this.onBackspace,
    required this.onEnter,
  });

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
      height: 300, 
      color: Colors.grey[200], 
      child: Column(
        children: [
          
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
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      textStyle: const TextStyle(fontSize: 14),
                      backgroundColor: Colors.grey[300], 
                    ),
                    child: const Icon(Icons.star, size: 20),
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
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      textStyle: const TextStyle(fontSize: 14),
                      backgroundColor: Colors.grey[300], 
                    ),
                    child: Text(_isNumeric ? 'ABC' : '123'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isUpperCase = !_isUpperCase;
                      });
                    }, 
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      textStyle: const TextStyle(fontSize: 14),
                      backgroundColor: Colors.grey[300], 
                    ),
                    child: Icon(_isUpperCase ? Icons.keyboard_capslock : Icons.keyboard),
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
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    textStyle: const TextStyle(fontSize: 14),
                    backgroundColor: Colors.grey[300], 
                  ),
                  child: const Icon(Icons.backspace, size: 20),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onEnter,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    textStyle: const TextStyle(fontSize: 14),
                    backgroundColor: Colors.grey[300], 
                  ),
                  child: const Icon(Icons.arrow_forward, size: 20),
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
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(30, 30), 
        padding: const EdgeInsets.all(0),
        textStyle: const TextStyle(fontSize: 14),
        backgroundColor: Colors.grey[300], 
      ),
      child: Text(label),
    );
  }
}
