import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String?> onSubmitted;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        textInputAction: TextInputAction.search,
        controller: controller,
        onSubmitted: onSubmitted,
        cursorColor: const Color(0xFF7A7A7A),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xffE6E6E6),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 25,
            color: Color(0xFF6B6B6B),
          ),
          hintText: 'Введите название',
          hintStyle: const TextStyle(color: Color(0xFF7A7A7A)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          isDense: true,
        ),
      ),
    );
  }
}
