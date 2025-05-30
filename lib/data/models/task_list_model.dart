import 'package:assignment_task_manager/data/models/task_details_model.dart';


class TaskListModel {
  late final String status;
  late final List<TaskDetailsModel> taskList;

  TaskListModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    if (jsonData['data'] != null) {
      List<TaskDetailsModel> list = [];
      for (Map<String, dynamic> task in jsonData['data']) {
        list.add(TaskDetailsModel.fromJson(task));
      }
      taskList = list;
    } else {
      taskList = [];
    }
  }
}
