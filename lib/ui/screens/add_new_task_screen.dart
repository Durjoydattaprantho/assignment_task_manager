import 'package:flutter/material.dart';
import 'package:assignment_task_manager/data/service/network_client.dart';
import 'package:assignment_task_manager/data/utils/urls.dart';
import 'package:assignment_task_manager/ui/widgets/pop_up_message.dart';
import 'package:assignment_task_manager/ui/widgets/screen_Background.dart';


class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 150),
                  Text(
                    'Add new task',
                    style: TextTheme.of(context).headlineMedium,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _titleController,
                    decoration: InputDecoration(hintText: 'Title'),
                    validator: (value) {
                      if (value!.trim().isEmpty == true) {
                        return 'Title Can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _detailsController,
                    maxLines: 8,
                    validator: (value) {
                      if (value!.trim().isEmpty == true) {
                        return 'Description Can\'t be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Details',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _onTaskSubmit,
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onTaskSubmit() {
    if (_formKey.currentState!.validate() == true) {
      createTask();
    }
    return;
  }

  Future<void> createTask() async {
    Map<String, dynamic> requestBody = {
      "title": _titleController.text.trim(),
      "description": _detailsController.text.trim(),
      "status": "New",
    };
    String url = Urls.createTaskUrl;

    NetworkResponse response = await NetworkClient.postRequest(
      url: url,
      body: requestBody,
    );
    if (response.statusCode == 200) {
      if (!mounted) return;
      showPopUp(context, 'Task Added');
      _titleController.clear();
      _detailsController.clear();
    } else {
      if (response.errorMessage == null) {
        if (!mounted) return;
        showPopUp(context, "Something went wrong");
      } else {
        if (!mounted) return;
        showPopUp(context, response.errorMessage);
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }
}
