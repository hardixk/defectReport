// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, unused_element, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FourthPage extends StatefulWidget {
  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  final List<String> defects = [
    'Buff',
    'Roughness',
    'Plating Short',
    'Pin Hole',
    'Peel Off',
    'Burn Mark',
    'Burning',
    'Patch Mark',
    'Waviness',
    'Whiteness',
    'Dull Shade',
    'Crack',
    'Pit Mark',
    'Pitting',
    'Dust',
    'Warpage',
    'Lock Band',
    'Damage',
    'Shrinkage',
    'Yellow Shade',
    'Deep Cut',
    'Scratch',
    'Dent',
    'Sink Mark',
    'Gas Mark',
    'Burr',
    'Flash',
    'Weldline',
    'Silver Mark',
    'Black Spot',
    'Flow Mark',
    'Extra Material',
    'MOULDING SCRATCH',
    'Damage',
    'Plant Problem',
    'Other'
  ];

  Map<String, Map<String, int>> partDefectCounters = {};

  int totalDefectCounter = 0;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    data['defectiveProducts'] = 0.toString();
    data['nonDefectiveProducts'] = 0.toString();
    String name = data['name'].toString();
    String id = data['id'].toString();
    String lot = data['lot'].toString();
    String shop = data['shop'].toString();
    String lotSize = data['lotSize'].toString();
    String selectedProduct = data['selectedProduct'].toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Defect'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: $name'),
                    Text('EmpId: $id'),
                    Text('Lot Size: $lotSize'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Product: $selectedProduct'),
                    Text('Lot: $lot'),
                    Text('Shop: $shop'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Total Defect Counter: $totalDefectCounter'),
            SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: defects.length,
                itemBuilder: (context, index) {
                  final defect = defects[index];
                  final defectCounter =
                      partDefectCounters[selectedProduct] != null
                          ? partDefectCounters[selectedProduct]![defect] ?? 0
                          : 0;

                  return GestureDetector(
                    onDoubleTap: () {
                      setState(() {
                        if (partDefectCounters[selectedProduct] == null) {
                          partDefectCounters[selectedProduct] = {};
                        }
                        partDefectCounters[selectedProduct]![defect] =
                            (partDefectCounters[selectedProduct]![defect] ??
                                    0) +
                                1;
                        totalDefectCounter++;
                      });
                    },
                    child: GridTile(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(defect),
                              SizedBox(height: 4.0),
                              Text('$defectCounter'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    data['date'] = DateTime.now().toString();
                    Map<String, dynamic> partInfo = {
                      'Product': selectedProduct,
                    };

                    partDefectCounters[selectedProduct]?.forEach((key, value) {
                      partInfo[key] = value;
                    });

                    partInfo['totalDefects'] = totalDefectCounter;
                    //_resetDefectData();
                    partInfo.addAll(data);
                    Navigator.pushNamed(context, '/third', arguments: partInfo);
                  },
                  child: Text('Next'),
                ),
                ElevatedButton(
                  onPressed: _generateCSVReport,
                  child: Text('Generate CSV Report'),
                ),
                ElevatedButton(
                  onPressed: () {
                    data['date'] = DateTime.now().toString();
                    Map<String, dynamic> partInfo = {
                      'Product': selectedProduct,
                    };

                    partDefectCounters[selectedProduct]?.forEach((key, value) {
                      partInfo[key] = value;
                    });

                    partInfo['totalDefects'] = totalDefectCounter;
                    partInfo.addAll(data);
                    Navigator.pushNamed(context, '/fifth', arguments: partInfo);
                  },
                  child: Text('Lot Complete'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _resetDefectData() {
    setState(() {
      partDefectCounters.clear();
      totalDefectCounter = 0;
    });
  }

  void _showDefectDeleteDialog(int defectIndex) {
    // Implement the dialog if needed
  }

  Future<void> _generateCSVReport() async {
    try {
      final String csv = _convertToCSV();
      const String path = '/storage/emulated/0/Download/report.csv';
      final File file = File(path);
      await file.writeAsString(csv);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('CSV Report Generated Successfully!'),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      print('Error generating CSV report: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error generating CSV report. Please try again.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  String _convertToCSV() {
    final StringBuffer buffer = StringBuffer();

    // Write CSV header
    buffer.writeln('PART NAME,${defects.join(',')}');

    // Write data for each part
    partDefectCounters.forEach((part, defects) {
      final List<String> defectValues =
          defects.values.map((value) => value.toString()).toList();
      buffer.writeln('$part,${defectValues.join(',')}');
    });

    return buffer.toString();
  }
}
