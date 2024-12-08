import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';

class OwnerSelector extends StatelessWidget {
  final String? selectedOwner;
  final Function(String?) onOwnerChanged;

  OwnerSelector({required this.selectedOwner, required this.onOwnerChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<String>(
            contentPadding: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            tileColor: Colors.grey,
            value: "First Owner",
            groupValue: selectedOwner,
            title: Text("1st Owner",
                style: TextStyle(fontSize: 10, color: Colors.white)),
            onChanged: onOwnerChanged,
          ),
        ),
        SizedBox(width: 2),
        Expanded(
          child: RadioListTile<String>(
            contentPadding: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            tileColor: Colors.grey,
            value: "Second Owner",
            groupValue: selectedOwner,
            title: Text("2nd Owner",
                style: TextStyle(fontSize: 10, color: Colors.white)),
            onChanged: onOwnerChanged,
          ),
        ),
        SizedBox(width: 2),
        Expanded(
          child: RadioListTile<String>(
            contentPadding: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            tileColor: Colors.grey,
            value: "third Owner",
            groupValue: selectedOwner,
            title: Text("3rd Owner",
                style: TextStyle(fontSize: 10, color: Colors.white)),
            onChanged: onOwnerChanged,
          ),
        ),
      ],
    );
  }
}
