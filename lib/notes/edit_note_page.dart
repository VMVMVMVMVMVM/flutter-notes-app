






import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'notes.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({Key? key}) : super(key: key);

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            onPressed: () {
              // procedure to create data
              final user = NotesInfo(
                id: '' ,
                title:_titleController.text ,
                description:_descriptionController.text ,
                createdTime: DateTime.now() ,
              );

              saveNotes(user);

              Navigator.pop(context);
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // SizedBox(height: 20,),
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
               // maxLines: 3,
                textInputAction: TextInputAction.done,

                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
// created data
  Future saveNotes (NotesInfo notesInfo) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc();
    notesInfo.id  = docUser.id;

    final json = notesInfo.toJson();
    await docUser.set(json);



  }

}


