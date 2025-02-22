import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controllers for the form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _batchDateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  String? _selectedCategoryId;
  DateTime? _expiryDate; // Store the expiry date

  // Fetch categories for the dropdown
  Future<List<Map<String, dynamic>>> _fetchCategories() async {
    try {
      final categoriesSnapshot = await _firestore.collection('categories').get();
      return categoriesSnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc.data().containsKey('name') ? doc['name'] : 'Unnamed',
        };
      }).toList();
    } catch (e) {
      print('Error fetching categories: $e');
      throw e;
    }
  }

  // Add product to Firestore
  Future<void> _addProduct() async {
    if (_nameController.text.isEmpty || _quantityController.text.isEmpty || _selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all required fields.")));
      return;
    }

    try {
      await _firestore.collection('products').add({
        'ProductId': _firestore.collection('products').doc().id,
        'Name': _nameController.text,
        'Quantity': int.parse(_quantityController.text),
        'ExpiryDate': _expiryDate,
        'BatchDate': DateTime.parse(_batchDateController.text),
        'Location': _locationController.text,
        'CategoryId': _selectedCategoryId,
      });

      // Clear fields after adding
      _nameController.clear();
      _quantityController.clear();
      _expiryDateController.clear();
      _batchDateController.clear();
      _locationController.clear();
      _selectedCategoryId = null;
      _expiryDate = null; // Reset expiry date

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product added successfully.")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error adding product: $e")));
    }
  }

  // Show date picker for selecting a date
  Future<void> _selectDate(BuildContext context, TextEditingController controller, {bool isExpiryDate = false}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = "${picked.toLocal()}".split(' ')[0]; // Format as YYYY-MM-DD
      if (isExpiryDate) {
        _expiryDate = picked; // Store expiry date
      } else {
        // Validate batch date against expiry date
        if (_expiryDate != null && picked.isAfter(_expiryDate!)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Batch date cannot be after expiry date.")));
          controller.clear(); // Clear batch date if invalid
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _expiryDateController,
              decoration: InputDecoration(labelText: 'Expiry Date (YYYY-MM-DD)'),
              readOnly: true, // Make it read-only for date picker
              onTap: () => _selectDate(context, _expiryDateController, isExpiryDate: true), // Date picker on tap
            ),
            TextField(
              controller: _batchDateController,
              decoration: InputDecoration(labelText: 'Batch Date (YYYY-MM-DD)'),
              readOnly: true, // Make it read-only for date picker
              onTap: () => _selectDate(context, _batchDateController), // Date picker on tap
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Storage Location'),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error fetching categories: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No categories found');
                }
                return DropdownButton<String>(
                  hint: Text('Select categories'),
                  value: _selectedCategoryId,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategoryId = newValue;
                    });
                  },
                  items: snapshot.data!.map((category) {
                    return DropdownMenuItem<String>(
                      value: category['id'],
                      child: Text(category['name']!),
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addProduct,
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}