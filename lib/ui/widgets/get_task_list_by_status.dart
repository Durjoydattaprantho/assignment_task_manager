import 'package:assignment_task_manager/data/models/task_details_model.dart';
import 'package:assignment_task_manager/data/models/task_list_model.dart';
import 'package:assignment_task_manager/data/service/network_client.dart';
import 'package:assignment_task_manager/data/utils/urls.dart';


Future<List<TaskDetailsModel>> getTaskListByStatus({
  required String status,
}) async {
  List<TaskDetailsModel> taskList = [];

  NetworkResponse response = await NetworkClient.getRequest(
    url: Urls.getTaskUrl(status),
  );
  if (response.statusCode == 200) {
    TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
    taskList = taskListModel.taskList;
  } else {
    taskList = [];
  }

  return taskList;
}
