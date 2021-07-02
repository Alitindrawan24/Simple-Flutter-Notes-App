import 'dart:convert';

class Note {
  String id;
  String title;
  String content;
  String createdAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> parsedJson) {
    return Note(
      id: parsedJson['id'],
      title: parsedJson['title'],
      content: parsedJson['content'],
      createdAt: parsedJson['createdAt'],
    );
  }

  static List<Note> listFromJson(List<dynamic> list) {
    List<Note> rows = list.map((i) => Note.fromJson(i)).toList();
    return rows;
  }

  static List<Note> listFromString(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Note>((json) => Note.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'createdAt': createdAt,
      };
}
