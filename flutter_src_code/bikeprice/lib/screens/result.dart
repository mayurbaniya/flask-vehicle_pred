import 'package:bikeprice/screens/home.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final Map<String, dynamic> responseData;
  final Map<String, dynamic> vehicleInfo;

  Result({required this.responseData, required this.vehicleInfo});

  @override
  Widget build(BuildContext context) {
    final prediction = responseData['prediction'];
    final predictionValue = prediction is String
        ? double.tryParse(prediction) ?? 0
        : prediction.toDouble();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Hurray🎉',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'For ',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    TextSpan(
                      text: '${vehicleInfo['age']}',
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' years old\n',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    TextSpan(
                      text: '${vehicleInfo['bike_name']}',
                      style: TextStyle(
                        color: Colors.tealAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '\nWhich is driven for\n',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    TextSpan(
                      text: '${vehicleInfo['kms_driven']} KMs',
                      style: TextStyle(
                        color: Colors.tealAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '\n You can expect about ',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    TextSpan(
                      text: '\n ${predictionValue.toStringAsFixed(0)} ₹',
                      style: TextStyle(
                        color: predictionValue < 50000
                            ? Colors.redAccent
                            : Colors.green,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Back to Home',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white12,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
