import 'package:flutter/material.dart';
import 'package:google_maps_app/features/google_map/data/models/get_perdicitions_result/result.dart';
import 'package:google_maps_app/features/google_map/presentation/views/widgets/search_location_section/peridication_item.dart';

class PerdictionsList extends StatelessWidget {
  const PerdictionsList({
    super.key,
    required this.places,
  });
  final List<Result> places;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade500,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: places.length,
        itemBuilder: (context, index) => PeridicationItem(
          place: places[index],
        ),
      ),
    );
  }
}
