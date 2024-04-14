// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';

class FifthPage extends StatefulWidget {
  const FifthPage({super.key});
  @override
  _FifthPageState createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var defectCounter = data['defectCounter'];
    var totalDefectCounter = data['totalDefectCounter'];
    final int totalParts = int.tryParse(data['lotSize']!) ?? 0;
    int defectiveProducts = int.tryParse(data['defectiveProducts']!) ?? 0;
    int nonDefectiveProducts = int.tryParse(data['nonDefectiveProducts']) ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Total Parts: $totalParts',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Defective Products: $defectiveProducts',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (defectiveProducts < totalParts) {
                      setState(() {
                        defectiveProducts++;
                        nonDefectiveProducts = totalParts - defectiveProducts;
                        data['defectiveProducts'] =
                            defectiveProducts.toString();
                        data['nonDefectiveProducts'] =
                            nonDefectiveProducts.toString();
                      });
                    }
                  },
                  child: Text('+'),
                ),
                SizedBox(width: 8.0),
                //Text('[$defectiveProducts]'),
                SizedBox(width: 8.0),

                ElevatedButton(
                  onPressed: () {
                    if (defectiveProducts > 0) {
                      setState(() {
                        defectiveProducts--;
                        nonDefectiveProducts = totalParts - defectiveProducts;
                        data['defectiveProducts'] =
                            defectiveProducts.toString();
                        data['nonDefectiveProducts'] =
                            nonDefectiveProducts.toString();
                      });
                    }
                  },
                  child: Text('-'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Non-Defective Products: $nonDefectiveProducts',
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
                onPressed: () {
                  data['defectCounters'] =
                      defectCounter; // Pass the updated defectCounters map
                  data['totalDefectCounter'] = totalDefectCounter;
                  Navigator.pushNamed(context, '/', arguments: data);
                },
                child: Text('Exit'))
          ],
        ),
      ),
    );
  }
}
