import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class BikeInput extends StatelessWidget {
  final bool hideBikeField;
  final bool isBikeTFEnabled;
  final TextEditingController bikeController;
  final FocusNode bikeFocusNode;
  final Function(String) filterBikes;
  final List<String> filteredBikes;
  final String? selectedBike;
  final Function(String) onBikeSelected;

  BikeInput({
    required this.hideBikeField,
    required this.isBikeTFEnabled,
    required this.bikeController,
    required this.bikeFocusNode,
    required this.filterBikes,
    required this.filteredBikes,
    required this.selectedBike,
    required this.onBikeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: isBikeTFEnabled,
      controller: bikeController,
      focusNode: bikeFocusNode,
      onChanged: filterBikes,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffix: Icon(Icons.search, color: Colors.grey, size: 22),
        hintText: 'Search for a bike...',
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
        filled: true,
        fillColor: Colors.black87,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
          borderRadius: BorderRadius.circular(8.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ).pSymmetric(v: 20);
  }
}
