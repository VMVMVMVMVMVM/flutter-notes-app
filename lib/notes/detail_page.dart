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
    _titleController.text = widget.documentSnapshot["title"];
    _descriptionController.text =
        widget.documentSnapshot["description"].toString();
  }


  Future<void> _update() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.documentSnapshot.id)
        .update({
          "title": _titleController.text,
          "description": _descriptionController.text
        })
        .then((_) => print('success'))
        .catchError((error) => print('Failed: $error'));

    _titleController.text = '';
    _descriptionController.text = '';
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
              _update();

              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => NotePage()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            //controller: _titleController,
            initialValue: widget.documentSnapshot["title"],
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
            initialValue: widget.documentSnapshot["description"],
            maxLines: 3,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 24,
            ),
            decoration: InputDecoration(
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
