import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, Map<String, Color>> _events = {};
  final TextEditingController _eventController = TextEditingController();
  Color _selectedColor = Colors.blue;
  bool _showCustomNotification = false;
  Timer? _notificationTimer;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Calendario de Rutinas'),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => _selectedDay == day,
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    calendarFormat: CalendarFormat.month,
                    eventLoader: (day) {
                      return _events[day]?.keys.toList() ?? [];
                    },
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, date, events) {
                        if (_events[date] != null && _events[date]!.isNotEmpty) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _events[date]!.entries.map((entry) {
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: entry.value,
                                  shape: BoxShape.circle,
                                ),
                              );
                            }).toList(),
                          );
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_selectedDay != null)
                    ElevatedButton(
                      onPressed: () {
                        _showAddEventDialog(context);
                      },
                      child: const Text('Agregar evento'),
                    ),
                  const SizedBox(height: 20),
                  _buildEventList(),
                ],
              ),
              if (_showCustomNotification) _buildCustomNotification(),
            ],
          ),
        );
      },
    );
  }

  void _showAddEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Agregar Evento con Color'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _eventController,
                    autofocus: true,
                    decoration: const InputDecoration(hintText: 'Evento'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _showColorPickerDialog(setState);
                    },
                    child: const Text('Seleccionar Color'),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _selectedColor,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    if (_eventController.text.isEmpty || _selectedDay == null) {
                      return;
                    }

                    setState(() {
                      if (_events[_selectedDay] != null) {
                        _events[_selectedDay]![_eventController.text] = _selectedColor;
                      } else {
                        _events[_selectedDay!] = {
                          _eventController.text: _selectedColor,
                        };
                      }

                      _showCustomNotificationMessage();
                      _eventController.clear();
                    });

                    Navigator.pop(context);
                  },
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showColorPickerDialog(StateSetter setState) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar Color'),
          content: MaterialColorPicker(
            selectedColor: _selectedColor,
            onColorChange: (color) {
              setState(() {
                _selectedColor = color;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _showCustomNotificationMessage() {
  if (!mounted) return; 

  setState(() {
    _showCustomNotification = true;
  });

  _notificationTimer = Timer(const Duration(seconds: 3), () {
    if (!mounted) return; 

    setState(() {
      _showCustomNotification = false;
    });
  });
}

  Widget _buildCustomNotification() {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          'Evento guardado con éxito',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    if (_selectedDay == null || _events[_selectedDay] == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No hay eventos para este día.'),
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/empty.jpg',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ],
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: _events[_selectedDay]!.length,
        itemBuilder: (context, index) {
          String event = _events[_selectedDay]!.keys.elementAt(index);
          Color color = _events[_selectedDay]!.values.elementAt(index);
          return ListTile(
            title: Text(event),
            leading: CircleAvatar(
              backgroundColor: color,
            ),
          );
        },
      ),
    );
  }
}
