import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'note_page.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  DetailPage({Key? key, required this.documentSnapshot}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController _titleController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.documentSnapshot["title"].toString();
    _descriptionController.text =
        widget.documentSnapshot["description"].toString();
  }

  Future<void> _update() async {
    print("DocumentSnapshotId: ${widget.documentSnapshot.id}");
    await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.documentSnapshot.id)
        .update({
          "title": _titleController.text,
          "description": _descriptionController.text
        })
        .then((_) => print('success'))
        .catchError((error) => print('Failed: $error'));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Changes updated successfully',
        ),

      ),
    );

    //_titleController.text = '';
    // _descriptionController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit a page'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: () {
              _update().then((value) {
                Navigator.of(context).pop();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _titleController,
            textInputAction: TextInputAction.next,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            decoration: InputDecoration(
              hintText: 'Title',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Title should not be empty';
              }
            },
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: _descriptionController,
            maxLines: null,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 24,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Description',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Description should not be empty';
              }
            },
          )
        ],
      ),
    );
  }
}
