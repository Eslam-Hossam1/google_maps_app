
import 'package:flutter/material.dart';
import 'package:google_maps_app/features/google_map/presentation/views/widgets/search_location_section/peridication_list.dart';
import 'package:google_maps_app/features/google_map/presentation/views/widgets/search_location_section/serach_location_text_field.dart';

class SearchLocationSection extends StatelessWidget {
  const SearchLocationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      right: 20,
      left: 20,
      child: Column(
        children: [
          SearchLocationTextField(),
          PerdictionsList(),
        ],
      ),
    );
  }
}
