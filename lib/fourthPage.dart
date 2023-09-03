// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class FourthPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  final List<String> defects = [
    'Defect 1',
    'Defect 2',
    'Defect 3',
    'Defect 4',
    'Defect 5',
    'Defect 6',
    'Defect 7',
    'Defect 8',
    'Defect 9',
    'Defect 10',
    'Defect 11',
    'Defect 12',
    'Defect 13',
    'Defect 14',
    'Defect 15',
    'Defect 16',
    'Defect 17',
    'Defect 18',
    'Defect 19',
    'Defect 20',
    'Defect 21',
    'Defect 22',
    'Defect 23',
    'Defect 24',
    'Defect 25',
    'Defect 26',
    'Defect 27',
    'Defect 28',
    'Defect 29',
    'Defect 30',
    'Defect 31',
    'Defect 32',
    'Defect 33',
    'Defect 34',
    'Defect 35',
    'Defect 36',

    // Add more defects here
  ];

  Map<String, int> defectCounters = {};
  Set<String> selectedDefects = {};
  int totalDefectCounter = 0;

  @override
  Widget build(BuildContext context) {
    //String date = DateTime.now().toString();
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
    //var lotCheck = 0;
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
                  crossAxisCount: 4, // 4 columns
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: defects.length,
                itemBuilder: (context, index) {
                  final defect = defects[index];
                  final defectCounter = defectCounters[defect] ?? 0;

                  return GestureDetector(
                    onDoubleTap: () {
                      setState(() {
                        defectCounters[defect] = defectCounter + 1;
                        totalDefectCounter++;
                      });
                    },
                    onLongPress: () {
                      _showDefectDeleteDialog(index);
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
                    // Create a map to store the part information
                    Map<String, dynamic> partInfo = {
                      'Product': selectedProduct,
                    };

                    // Add defect count for each defect to the map
                    for (int i = 0; i < defects.length; i++) {
                      String defect = defects[i];
                      int defectCounter = defectCounters[defect] ?? 0;
                      partInfo['defect$i'] = defectCounter;
                    }

                    // Add total defect counter to the map
                    partInfo['totalDefects'] = totalDefectCounter;
                    _resetDefectData();
                    // Add other data from 'data' to the map
                    partInfo.addAll(data);
                    Navigator.pushNamed(context, '/third', arguments: partInfo);
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _resetDefectData() {
    setState(() {
      defectCounters.clear();
      //totalDefectCounter = 0;
    });
  }

  void _showDefectDeleteDialog(int defectIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final defect = defects[defectIndex];
        return AlertDialog(
          title: Text('Reduce Defect Count'),
          content: Text('Do you want to reduce the count of $defect?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  final defectCounter = defectCounters[defect] ?? 0;
                  if (defectCounter > 0) {
                    defectCounters[defect] = defectCounter - 1;
                    totalDefectCounter--;
                  }
                });
                Navigator.pop(context);
              },
              child: Text('Reduce'),
            ),
          ],
        );
      },
    );
  }
}
