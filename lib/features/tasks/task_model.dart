class TaskModel {
  String id;
  String title;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  void markAsCompleted() {
    isCompleted = true;
  }

  void markAsIncomplete() {
    isCompleted = false;
  }

  void updateTitle(String newTitle) {
    title = newTitle;
  }


  // Factory constructor to create a TaskModel from a map
  factory TaskModel.fromMap(Map<String, dynamic> data) {
    return TaskModel(
      id: data['id'],
      title: data['title'],
      isCompleted: data['isCompleted'] ?? false,
    );
  }

  // Method to convert a TaskModel to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

}