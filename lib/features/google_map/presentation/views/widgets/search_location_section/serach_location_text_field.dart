
import 'package:flutter/material.dart';

class SearchLocationTextField extends StatelessWidget {
  const SearchLocationTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
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