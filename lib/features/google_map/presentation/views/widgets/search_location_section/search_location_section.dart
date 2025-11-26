import 'package:flutter/material.dart';
import 'package:google_maps_app/features/google_map/data/data_source/places_peridications_remote_data_source/places_peridications_remote_data_source.dart';
import 'package:google_maps_app/features/google_map/data/models/get_perdicitions_result/result.dart';
import 'package:google_maps_app/features/google_map/presentation/views/widgets/search_location_section/peridication_list.dart';
import 'package:google_maps_app/features/google_map/presentation/views/widgets/search_location_section/serach_location_text_field.dart';

class SearchLocationSection extends StatefulWidget {
  const SearchLocationSection({
    super.key,
  });

  @override
  State<SearchLocationSection> createState() => _SearchLocationSectionState();
}

class _SearchLocationSectionState extends State<SearchLocationSection> {
  TextEditingController searchLocationController = TextEditingController();
  bool showPredictionList = false;
  List<Result> places = [];

  @override
  void initState() {
    super.initState();
    searchLocationController.addListener(() {
      onTyping(searchLocationController.text);
    });
  }

  @override
  void dispose() {
    // Always dispose controllers to prevent memory leaks
    searchLocationController.dispose();
    super.dispose();
  }

  void onTyping(String text) async {
    // Trim whitespace to handle empty strings with spaces
    final trimmedText = text.trim();
    
    if (trimmedText.isNotEmpty) {
      try {
        final results = await PlacesPeridicationsRemoteDataSource()
            .getPerdications(place: trimmedText);
        
        // Check if widget is still mounted before calling setState
        if (mounted) {
          setState(() {
            places = results;
            showPredictionList = true;
          });
        }
      } catch (e) {
        // Handle errors gracefully
        if (mounted) {
          setState(() {
            places = [];
            showPredictionList = false;
          });
        }
        debugPrint('Error fetching predictions: $e');
      }
    } else {
      // Clear predictions when text is empty
      if (mounted) {
        setState(() {
          places = [];
          showPredictionList = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      right: 20,
      left: 20,
      child: Column(
        children: [
          SearchLocationTextField(
            controller: searchLocationController,
          ),
          if (showPredictionList && places.isNotEmpty)
            PerdictionsList(
              places: places,
            ),
        ],
      ),
    );
  }
}