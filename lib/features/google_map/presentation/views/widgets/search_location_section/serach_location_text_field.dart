import 'package:flutter/material.dart';

class SearchLocationTextField extends StatelessWidget {
  const SearchLocationTextField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Search location',
        suffixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
