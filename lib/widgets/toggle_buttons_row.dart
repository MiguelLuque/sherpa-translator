import 'package:flutter/material.dart';

class ToggleButtonsRow extends StatefulWidget {
  final TextEditingController controller;
  const ToggleButtonsRow({super.key, required this.controller});

  @override
  _ToggleButtonsRowState createState() => _ToggleButtonsRowState(controller);
}

class _ToggleButtonsRowState extends State<ToggleButtonsRow> {
  final List<bool> _selected = <bool>[true, false, false];
  final TextEditingController _controller;

  final List<String> options = [
    'Automatico',
    'Formal',
    'Informal',
  ];

  @override
  //init state with first language
  void initState() {
    super.initState();
    _controller.text = options[0].toString();
  }

  _ToggleButtonsRowState(this._controller);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        direction: Axis.horizontal,
        onPressed: (int index) {
          setState(() {
            _controller.text = options[index].toString();
            // The button that is tapped is set to true, and the others to false.
            for (int i = 0; i < _selected.length; i++) {
              _selected[i] = i == index;
            }
          });
        },
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        selectedBorderColor: Colors.blue[700],
        selectedColor: Colors.white,
        fillColor: Colors.blue[200],
        color: Colors.blue[400],
        constraints: const BoxConstraints(
          minHeight: 40.0,
          minWidth: 80.0,
        ),
        isSelected: _selected,
        //build text widgets
        children: options.map((String option) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(option),
          );
        }).toList());
  }
}
