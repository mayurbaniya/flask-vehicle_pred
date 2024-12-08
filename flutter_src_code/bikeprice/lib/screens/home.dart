// ignore_for_file: prefer_const_constructors

import 'package:bikeprice/screens/result.dart';
import 'package:bikeprice/service/helper.dart';
import 'package:bikeprice/widgets/kms_input.dart';
import 'package:flutter/material.dart';
import 'package:bikeprice/utils/data.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:bikeprice/widgets/brand_input.dart';
import 'package:bikeprice/widgets/bike_input.dart';
import 'package:bikeprice/widgets/owner_selector.dart';
import 'package:bikeprice/widgets/slider_widget.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool hideBrandList = true;
  bool hideBikeList = true;
  bool isBikeTFEnabled = false;
  bool hideBrandField = false;
  bool hideBikeField = false;
  bool _isLoading = false;

  List<String> bikes = bikeNames;
  List<String> brandList = brands;
  List<String> bikeListByBrand = [];
  List<String> filteredBikes = [];
  List<String> filteredBrands = [];
  String? selectedBike;
  String? selectedBrand;
  TextEditingController _bikeController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _KmsController = TextEditingController();
  FocusNode _brandFocusNode = FocusNode();
  FocusNode _bikeFocusNode = FocusNode();
  String? _selectedOwner = "null";
  double _vehicleAge = 1;
  double _vehiclePower = 80;
  String _kmsDriven = '';

  @override
  void initState() {
    super.initState();
    filteredBikes = bikes;
    filteredBrands = brandList;
  }

  @override
  void dispose() {
    _bikeController.dispose();
    _brandController.dispose();
    _KmsController.dispose();
    _brandFocusNode.dispose();
    _bikeFocusNode.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    bool isValid = true;
    String errorMessage = '';

    if (_brandController.text.isEmpty) {
      isValid = false;
      errorMessage = 'Brand is required.';
    } else if (_bikeController.text.isEmpty) {
      isValid = false;
      errorMessage = 'Bike is required.';
    } else if (_KmsController.text.isEmpty) {
      isValid = false;
      errorMessage = 'KMS Driven is required.';
    } else if (_selectedOwner == "null") {
      isValid = false;
      errorMessage = 'Please select an owner.';
    }

    if (!isValid) {
      _showVxErrorDialog(context, errorMessage);
    } else {
      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> bikeData = {
        'bike_name': _bikeController.text,
        'owner': _selectedOwner,
        'brand': _brandController.text,
        'kms_driven': int.tryParse(_KmsController.text) ?? 0,
        'age': _vehicleAge.toInt(),
        'power': _vehiclePower.toInt(),
      };

      List<Map<String, dynamic>> requestData = [bikeData];

      ApiService api = ApiService();
      var response = await api.sendPostRequest(requestData);

      setState(() {
        _isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Result(
            responseData: response,
            vehicleInfo: bikeData,
          ),
        ),
      );
    }
  }

  void _filterBikes(String query) {
    setState(() {
      if (query.isNotEmpty) {
        hideBikeList = false;
        hideBrandField = true;
        FocusScope.of(context).requestFocus(_bikeFocusNode);
      } else {
        hideBrandField = false;
        hideBikeList = true;
      }

      filteredBikes = bikeListByBrand
          .where((bike) => bike.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _hideList() {
    setState(() {
      hideBrandList = true;
      hideBikeList = true;
    });
  }

  void _getBikeList() {
    setState(() {
      bikeListByBrand = bikeNames
          .where((bike) =>
              bike.toLowerCase().contains(selectedBrand!.toLowerCase()))
          .toList();
      isBikeTFEnabled = true;
    });
  }

  void _filterBrands(String query) {
    setState(() {
      if (query.isNotEmpty) {
        hideBrandList = false;
      } else {
        hideBrandList = true;
        isBikeTFEnabled = false;
      }

      filteredBrands = brandList
          .where((brand) => brand.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _filterBikesByBrand(String brand) {
    setState(() {
      filteredBikes = bikes
          .where((bike) => bike.toLowerCase().contains(brand.toLowerCase()))
          .toList();
    });
  }

  void _showVxErrorDialog(BuildContext context, String errorMessage) {
    VxDialog.showAlert(
      context,
      actionTextColor: Colors.blue,
      barrierDismissible: true,
      title: "Validation Error",
      content: Text(errorMessage,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  void _showVxDialog(BuildContext context) {
    VxDialog.showAlert(context,
        actionTextColor: Colors.blue,
        barrierDismissible: true,
        title: "Vehicle Driven (in KMs)",
        content: Container(
          child: TextField(
            controller: _KmsController,
            onChanged: (val) {
              setState(() {
                _kmsDriven = val;
              });
            },
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              hintText: "eg: 3600Km",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(8.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.green,
                backgroundColor: Colors.transparent,
                semanticsLabel: "passing data to model",
                semanticsValue: "fetching results from model",
              ),
            )
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  "Predict Vehicle Price"
                      .text
                      .size(28)
                      .bold
                      .green400
                      .makeCentered()
                      .p16()
                      .shimmer(),
                  BrandInput(
                    hideBrandField: hideBrandField,
                    brandController: _brandController,
                    brandFocusNode: _brandFocusNode,
                    filterBrands: _filterBrands,
                    filteredBrands: filteredBrands,
                    selectedBrand: selectedBrand,
                    onBrandSelected: (brand) {
                      setState(() {
                        _hideList();
                        selectedBrand = brand;
                        _brandController.text = selectedBrand!;
                        filteredBrands = [];
                        _filterBikesByBrand(selectedBrand!);
                        _getBikeList();
                        FocusScope.of(context).requestFocus(_bikeFocusNode);
                      });
                    },
                  ),
                  hideBrandList
                      ? "".text.make()
                      : Expanded(
                          child: filteredBrands.isNotEmpty
                              ? ListView.builder(
                                  itemCount: filteredBrands.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        filteredBrands[index],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _hideList();
                                          selectedBrand = filteredBrands[index];
                                          _brandController.text =
                                              selectedBrand!;
                                          filteredBrands = [];
                                          _filterBikesByBrand(selectedBrand!);
                                          _getBikeList();
                                          FocusScope.of(context)
                                              .requestFocus(_bikeFocusNode);
                                        });
                                      },
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    '',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                        ),
                  BikeInput(
                    hideBikeField: hideBikeField,
                    isBikeTFEnabled: isBikeTFEnabled,
                    bikeController: _bikeController,
                    bikeFocusNode: _bikeFocusNode,
                    filterBikes: _filterBikes,
                    filteredBikes: filteredBikes,
                    selectedBike: selectedBike,
                    onBikeSelected: (bike) {
                      setState(() {
                        _hideList();
                        hideBikeField = true;
                        selectedBike = bike;
                        _bikeController.text = selectedBike!;
                        filteredBikes = [];
                      });
                    },
                  ),
                  hideBikeList
                      ? "".text.make()
                      : Expanded(
                          child: filteredBikes.isNotEmpty
                              ? ListView.builder(
                                  itemCount: filteredBikes.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        filteredBikes[index],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onTap: () {
                                        _hideList();
                                        hideBikeField = true;
                                        setState(() {
                                          selectedBike = filteredBikes[index];
                                          _bikeController.text = selectedBike!;
                                          filteredBikes =
                                              []; // Clear suggestions after selection
                                        });
                                      },
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    'No bikes found',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                        ),
                  OwnerSelector(
                    selectedOwner: _selectedOwner,
                    onOwnerChanged: (owner) {
                      setState(() {
                        _selectedOwner = owner;
                      });
                    },
                  ),
                  SliderWidget(
                    label: "Vehicle's Age",
                    value: _vehicleAge,
                    division: 49,
                    min: 1,
                    max: 50,
                    onChanged: (double value) {
                      setState(() {
                        _vehicleAge = value;
                      });
                    },
                  ),
                  SliderWidget(
                    label: "Vehicle's Power",
                    value: _vehiclePower,
                    division: 112,
                    min: 80,
                    max: 1200,
                    onChanged: (double value) {
                      setState(() {
                        _vehiclePower = value;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child:
                              "KMS Driven : ".text.white.bold.makeCentered()),
                      Expanded(
                          flex: 4,
                          child: KmsInput(
                            value: _kmsDriven,
                            onTap: (kms) {
                              _showVxDialog(context);
                            },
                          )),
                      Expanded(flex: 1, child: "Kms".text.make())
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(screenWidth * 0.9, 50)),
                    onPressed: () {
                      print('btn clicked');
                      _handleSubmit();
                    },
                    child: "Submit".text.white.make().shimmer(),
                  ),
                ],
              ),
            ),
    );
  }
}
