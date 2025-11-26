
import 'package:flutter/material.dart';
import 'package:google_maps_app/features/google_map/presentation/views/widgets/search_location_section/peridication_item.dart';

class PerdictionsList extends StatelessWidget {
  const PerdictionsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade500,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 7,
        itemBuilder: (context, index) => PeridicationItem(),
      ),
    );
  }
}




  

