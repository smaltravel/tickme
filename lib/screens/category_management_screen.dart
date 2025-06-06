import 'package:flutter/material.dart';
import 'package:tickme/models/category.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({Key? key}) : super(key: key);

  @override
  _CategoryManagementScreenState createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  List<Category> _categories = [];

  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => SimpleDialog(
                  title: Text('Add Category'),
                  children: [
                    TextField(
                      controller: _nameController,
                      maxLength: 50,
                    ),
                    TextButton(
                      onPressed: () => dismissDialog(),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => _addCategory(),
                      child: Text('Add'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  isThreeLine: true,
                  leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editCategory(index),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteCategory(index),
                  ),
                  title: Text(_categories[index].name),
                  subtitle: Text(_categories[index].id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _editCategory(int index) {
    // Implement the edit category flow.  This is placeholder for now.
    print('Editing category at index: $index');
    //  You would typically show a dialog or build a separate screen to
    //  allow the user to edit the category name.
  }

  void _deleteCategory(int index) {
    setState(() {
      if (index >= 0 && index < _categories.length) {
        _categories.removeAt(index);
      }
    });
  }

  void dismissDialog() {
    Navigator.of(context).pop();
  }

  void _addCategory() {
    final String name = _nameController.text;
    if (name.isNotEmpty) {
      _categories.add(Category(
          id: 'new_' + DateTime.now().millisecondsSinceEpoch.toString(),
          name: name));
      Navigator.of(context).pop();
    }
  }
}

class SimpleDialogOptions {
  Function onConfirm;
  Function onDismiss;

  SimpleDialogOptions({
    required this.onConfirm,
    required this.onDismiss,
  });
}
