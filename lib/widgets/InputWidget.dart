import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final String label;
  final bool password;
  final Icon icon;

  const InputWidget(this.label, this.password, this.icon, {super.key});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor = _isFocused ? Colors.orange : Colors.grey.shade400;
    Color iconColor = _isFocused ? Colors.orange : Colors.grey;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(widget.icon.icon, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              focusNode: _focusNode,
              obscureText: widget.password,
              decoration: InputDecoration(
                hintText: widget.label,
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
