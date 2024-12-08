import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class BrandInput extends StatelessWidget {
  final bool hideBrandField;
  final TextEditingController brandController;
  final FocusNode brandFocusNode;
  final Function(String) filterBrands;
  final List<String> filteredBrands;
  final String? selectedBrand;
  final Function(String) onBrandSelected;

  BrandInput({
    required this.hideBrandField,
    required this.brandController,
    required this.brandFocusNode,
    required this.filterBrands,
    required this.filteredBrands,
    required this.selectedBrand,
    required this.onBrandSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: brandController,
      focusNode: brandFocusNode,
      onChanged: filterBrands,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffix: Icon(Icons.search, color: Colors.grey, size: 22),
        hintText: 'Search for a brand...',
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
      ),
    ).pSymmetric(v: 20);
  }
}
