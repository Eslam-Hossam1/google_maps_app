import 'package:flutter/material.dart';

class PeridicationItem extends StatelessWidget {
  const PeridicationItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Location 1'),
      ),
    );
  }
}