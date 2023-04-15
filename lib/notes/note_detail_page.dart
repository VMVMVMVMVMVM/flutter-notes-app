




//class NoteDetailPage extends StatefulWidget {
//late NotesInfo note;
//NoteDetailPage({Key? key,required this.note}) : super(key: key);

//@override
//State<NoteDetailPage> createState() => _NoteDetailPageState();
//}

//class _NoteDetailPageState extends State<NoteDetailPage> {

//bool isLoading = false;

//@override
//Widget build(BuildContext context) {
//return Scaffold(
//appBar: AppBar(
//title: Text('Edit Notes'),
//actions: [
//IconButton(
//onPressed: () async {
//if (isLoading) return;

//await Navigator.of(context).push(
//  MaterialPageRoute(builder: (context) => EditNotePage()));
//},
//icon: Icon(Icons.edit_off_outlined),
//),
//IconButton(
//  onPressed: () async {
//  await FirebaseFirestore.instance
//    .collection('user')
//  .doc()
//.delete();

//Navigator.of(context).pop();
//},
//icon: Icon(Icons.delete)),
//],
// ),
// body: isLoading
//   ? Center(child: CircularProgressIndicator())
// : Padding(
//   padding: EdgeInsets.all(8),
// child: ListView(
// padding: EdgeInsets.symmetric(vertical: 8),
//children: [
//Text(
//title ,
//style: TextStyle(
//  color: Colors.black,
//fontSize: 22,
//fontWeight: FontWeight.bold),
//),
//SizedBox(
//height: 8,
//),
//Text(
//DateFormat.yMMMd().format(DateTime.now()),
//style: TextStyle(
//color: Colors.black,
//),
//),
//SizedBox(
//height: 8,
//),
//Text(
//description,
//style: TextStyle(color: Colors.black, fontSize: 18),
//)
//],
//),
//),
//);
//}
//}
