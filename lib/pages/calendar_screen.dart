import 'dart:async';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:rutinas_app/widgets/custom_notification_widget.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, Map<String, Color>> _events = {};
  final TextEditingController _eventController = TextEditingController();
  Color _selectedColor = Colors.blue;
  final FocusNode _focusNode = FocusNode();

  // Variables para la notificación personalizada
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
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
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
                        if (_events[date] != null &&
                            _events[date]!.isNotEmpty) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _events[date]!.entries.map((entry) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
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
              // Notificación personalizada
              if (_showCustomNotification)
                CustomNotificationWidget(
                  message: 'Evento guardado con éxito',
                ),
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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              FocusScope.of(context).requestFocus(_focusNode);
            });

            return AlertDialog(
              title: const Text('Agregar Evento con Color'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      controller: _eventController,
                      focusNode: _focusNode,
                      autofocus: true,
                      decoration: const InputDecoration(hintText: 'Evento'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<Color>(
                    value: _selectedColor,
                    items: [
                      DropdownMenuItem(
                        value: Colors.red,
                        child:
                            Text('Rojo', style: TextStyle(color: Colors.red)),
                      ),
                      DropdownMenuItem(
                        value: Colors.green,
                        child: Text('Verde',
                            style: TextStyle(color: Colors.green)),
                      ),
                      DropdownMenuItem(
                        value: Colors.blue,
                        child:
                            Text('Azul', style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                    onChanged: (color) {
                      setState(() {
                        _selectedColor = color!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
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
                    if (_eventController.text.isEmpty) {
                      return;
                    }

                    setState(() {
                      if (_events[_selectedDay] != null) {
                        _events[_selectedDay]![_eventController.text] =
                            _selectedColor;
                      } else {
                        _events[_selectedDay!] = {
                          _eventController.text: _selectedColor
                        };
                      }
                      // Mostrar la notificación personalizada
                      _showCustomNotificationMessage();
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

  // Muestra la notificación personalizada durante unos segundos
  void _showCustomNotificationMessage() {
    setState(() {
      _showCustomNotification = true;
    });

    // Ocultar la notificación después de 3 segundos
    _notificationTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showCustomNotification = false;
      });
    });
  }

  // Lista de eventos
  Widget _buildEventList() {
    if (_selectedDay == null || _events[_selectedDay] == null) {
      return const Text('No hay eventos para este día.');
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
