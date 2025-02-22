import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;

  // Method to add a new category
  void _addCategory() async {
    if (_categoryController.text.isNotEmpty) {
      await _firestore.collection('categories').add({
        'name': _categoryController.text,
        'description': _descriptionController.text,
      });
      _categoryController.clear();
      _descriptionController.clear();
    }
  }

  // Method to build category list
  Widget _buildCategoryList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('categories').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final categories = snapshot.data!.docs;

        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return ListTile(
              title: Text(category['name']),
              subtitle: Text(category['description']),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _editCategory(category.id, category['name'], category['description']);
                },
              ),
            );
          },
        );
      },
    );
  }

  // Method to edit an existing category
  void _editCategory(String categoryId, String name, String description) {
    _categoryController.text = name;
    _descriptionController.text = description;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category Name'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await _firestore.collection('categories').doc(categoryId).update({
                  'name': _categoryController.text,
                  'description': _descriptionController.text,
                });
                _categoryController.clear();
                _descriptionController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _categoryController,
                    decoration: InputDecoration(labelText: 'Category Name'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addCategory,
                ),
              ],
            ),
          ),
          Expanded(child: _buildCategoryList()),
        ],
      ),
    );
  }
}