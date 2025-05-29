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
    Color iconColor = _isFocused ? Color(0xffFD6929) : Color(0xffD9D9D9);

    return Container(
      width: 312,
      height: 46,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withAlpha(10),
              offset: Offset(0, 0),
              blurRadius: 8,
            )
          ]),
      child: Center(
        child: Row(
          children: [
            SizedBox(width: 24),
            Icon(widget.icon.icon, color: iconColor),
            SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                focusNode: _focusNode,
                obscureText: widget.password,
                decoration: InputDecoration(
                  hintText: widget.label,
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
