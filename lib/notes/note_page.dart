import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'edit_note_page.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notes App'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('user').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];

                    return ListTile(
                      title: Text(documentSnapshot['title']),
                      subtitle: Text(documentSnapshot['createdTime'].toString()),
                      trailing: IconButton(icon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),

                        onPressed: () async {

                          await showdialog(context);
                          _deleteNotes(documentSnapshot.id);
                        },
                      ),
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(documentSnapshot: documentSnapshot)));
                      },
                      // child: NoteCardWidget(note:note, index: index),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => EditNotePage()));
          },
          child: Icon(Icons.add),
        ),
      );
  }

  void _deleteNotes(String notesId) async {

    await FirebaseFirestore.instance.collection('user').doc(notesId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You have successfully deleted the notes'),
      ),
    );
  }

  Future<bool> showdialog(BuildContext context) async {
    bool? deletenote = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Really???'),
            content: Text('Do you want to delete the selected notes'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No')),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          );
        });
    return deletenote ?? false;
  }
}
