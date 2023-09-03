// ignore_for_file: file_names, prefer_const_constructors, library_private_types_in_public_api, unused_element
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final List<String> products = [
    'Product 1',
    'Product 2',
    'Product 3',
    // Add more products here
  ];
  List<String> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts.addAll(products);
  }

  void _filterProducts(String query) {
    setState(() {
      filteredProducts = products.where((product) {
        return product.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String name = data['name'].toString();
    String id = data['id'].toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Product'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Name: $name    EmpId: $id',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: _filterProducts,
              decoration: InputDecoration(
                labelText: 'Search Products',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(filteredProducts[index]),
                onTap: () {
                  String selectedProduct = filteredProducts[index];
                  Navigator.pushNamed(
                    context,
                    '/fourth',
                    arguments: {
                      ...data,
                      'selectedProduct': selectedProduct,
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
