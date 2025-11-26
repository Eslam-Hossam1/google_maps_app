import 'package:flutter/material.dart';
import 'package:google_maps_app/features/google_map/data/models/get_perdicitions_result/result.dart';

class PeridicationItem extends StatelessWidget {
  const PeridicationItem({
    super.key,
    required this.place,
  });
  final Result place;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        title: Text(place.place?.name ?? place.text?.primary ?? ''),
        subtitle: Text(place.text?.secondary ?? ''),
      ),
    );
  }
}
