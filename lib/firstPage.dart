// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api
// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: 'Employee ID',
              ),
            ),
            /*TextField(
              controller: lotController,
              decoration: const InputDecoration(
                labelText: 'Lot number',
              ),
            ),
            TextField(
              controller: batchController,
              decoration: const InputDecoration(
                labelText: 'Batch number',
              ),
            ),*/
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Map<String, String> data = {
                  'name': nameController.text,
                  'id': idController.text,
                };
                Navigator.pushNamed(context, '/second', arguments: data);
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
