



class NotesInfo {
  String? id;
  final String title;
  final String description;
  final DateTime createdTime;

  NotesInfo({
    required this.id,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  factory NotesInfo.fromJson(Map<String, dynamic> json) {
    return NotesInfo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdTime: DateTime.parse(json['Createdtime']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdTime': createdTime.toIso8601String(),
    };
  }
}
