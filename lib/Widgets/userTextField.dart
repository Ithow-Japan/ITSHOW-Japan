import 'package:flutter/material.dart';

class UserTextField extends StatefulWidget {
  final String userId; // 변경 불가능한 사용자 ID
  final String nickname;
  final String email;

  const UserTextField({
    super.key,
    required this.userId,
    required this.nickname,
    required this.email,
  });

  @override
  _UserTextFieldState createState() => _UserTextFieldState();
}

class _UserTextFieldState extends State<UserTextField> {
  bool _isEditingNickname = false;
  bool _isEditingEmail = false;

  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _nicknameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _nicknameController.text = widget.nickname;
    _emailController.text = widget.email;

    _nicknameFocus.addListener(() {
      if (!_nicknameFocus.hasFocus) {
        Future.delayed(Duration(milliseconds: 100), () {
          if (!_nicknameFocus.hasFocus) {
            setState(() => _isEditingNickname = false);
          }
        });
      }
    });

    _emailFocus.addListener(() {
      if (!_emailFocus.hasFocus) {
        Future.delayed(Duration(milliseconds: 100), () {
          if (!_emailFocus.hasFocus) {
            setState(() => _isEditingEmail = false);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _nicknameFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  void _toggleEditing(String field) {
    setState(() {
      if (field == "nickname") {
        _isEditingNickname = true;
        _isEditingEmail = false;
      } else if (field == "email") {
        _isEditingNickname = false;
        _isEditingEmail = true;
      }
    });

    // 🔥 위젯이 리빌드된 후 자동으로 포커싱되도록 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (field == "nickname") {
        _nicknameFocus.requestFocus();
      } else if (field == "email") {
        _emailFocus.requestFocus();
      }
    });
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool isEditing,
    required VoidCallback onEdit,
    bool isReadOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xFFFD6929),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                enabled: !isReadOnly && isEditing,
                readOnly: isReadOnly,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 4),
                ),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isReadOnly ? Colors.grey : Colors.black,
                ),
              ),
            ),
            if (!isReadOnly && !isEditing)
              GestureDetector(
                onTap: onEdit,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField(
          label: "닉네임",
          controller: _nicknameController,
          focusNode: _nicknameFocus,
          isEditing: _isEditingNickname,
          onEdit: () => _toggleEditing("nickname"),
        ),
        _buildTextField(
          label: "이메일",
          controller: _emailController,
          focusNode: _emailFocus,
          isEditing: _isEditingEmail,
          onEdit: () => _toggleEditing("email"),
        ),
        _buildTextField(
          label: "아이디",
          controller: TextEditingController(text: widget.userId),
          focusNode: FocusNode(),
          isEditing: false,
          onEdit: () {},
          isReadOnly: true, // 아이디는 수정 불가능
        ),
      ],
    );
  }
}
