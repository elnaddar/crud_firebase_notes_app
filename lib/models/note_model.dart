import 'dart:convert';

class NoteModel {
  final String? title;
  final String note;
  final DateTime timestamp;
  NoteModel({
    this.title,
    required this.note,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  NoteModel copyWith({
    String? title,
    String? note,
    DateTime? timestamp,
  }) {
    return NoteModel(
      title: title ?? this.title,
      note: note ?? this.note,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'note': note,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map['title'] != null ? map['title'] as String : null,
      note: map['note'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NoteModel(title: $title, note: $note, timestamp: $timestamp)';

  @override
  bool operator ==(covariant NoteModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.note == note &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode => title.hashCode ^ note.hashCode ^ timestamp.hashCode;
}
