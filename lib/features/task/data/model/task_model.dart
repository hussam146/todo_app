
class TaskModel {
  final int? id;
  final String title;
  final String note;
  final String startTime;
  final String endTime;
  final String date;
  final int isCompleted;
  final int color;
  
  TaskModel({
    this.id,
    required this.title,
    required this.note,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.isCompleted,
    required this.color,
  });

  factory TaskModel.fromMap(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      note: json['note'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      date: json['date'],
      isCompleted: json['isCompleted'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'startTime': startTime,
      'endTime': endTime,
      'date' : date,
      'isCompleted': isCompleted,
      'color': color
    };
  }
}
