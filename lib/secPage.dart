// ignore_for_file: library_private_types_in_public_api, file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  TextEditingController lotController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  TextEditingController lotSizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Batch Information"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: lotController,
                decoration: const InputDecoration(
                  labelText: 'Lot number',
                ),
              ),
              TextField(
                controller: lotSizeController,
                decoration: const InputDecoration(
                  labelText: 'Lot Size',
                ),
              ),
              TextField(
                controller: shopController,
                decoration: const InputDecoration(
                  labelText: 'Shop number',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // ignore: unused_local_variable
                  data['lot'] = lotController.text;
                  data['lotSize'] = lotSizeController.text;
                  data['shop'] = shopController.text;
                  Navigator.pushNamed(context, '/third', arguments: data);
                },
                child: const Text('Next'),
              ),
            ],
          )),
    );
  }
}
