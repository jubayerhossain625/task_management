import 'package:get/get.dart';
import 'package:task_management/common/widgets/custom_toast.dart';
import 'package:task_management/features/home/respository/home_respostory.dart';
import '../model/create_task_resposeModel.dart';
import '../model/delete_task_response_model.dart';
import '../model/my_profile.dart';
import '../model/task_list_response_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rxn<TaskListResponseModel?> allTask = Rxn<TaskListResponseModel>();
  Rxn<MyProfileResponseModel?> myProfile = Rxn<MyProfileResponseModel>();

  Future<void> getAllTask() async {
    TaskListResponseModel? responseModel = await HomeRepository().getTaskList();
    if (responseModel != null) {
      allTask.value = responseModel;
      update();
    }
  }

  Future<void> getMyProfile() async {
    MyProfileResponseModel? responseModel = await HomeRepository().getMyProfile();
    if (responseModel != null) {
      myProfile.value = responseModel;
      update();
    }
  }

  Future<void> getDeleteTask(String taskId) async {
    TaskDeleteResponseModel? responseModel = await HomeRepository().deleteTask(taskId);
    if (responseModel != null) {
      CustomToast.showSuccess(responseModel.message ?? '');
      getAllTask();
    }
  }

  Future<void> getCreateTask(Map<String, String> body) async {
    TaskCreateResponseModel? responseModel = await HomeRepository().createTask(body);
    if (responseModel != null) {
      CustomToast.showSuccess(responseModel.message ?? '');
      getAllTask();
    }
  }

  @override
  void onInit() {
    getAllTask();
    getMyProfile();
    super.onInit();
  }

  void showCreateTaskDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create New Task'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(color: Color(0xFFEBEBEB),),
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel',style: const TextStyle(color: Colors.black),),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // If form validation passes, call getCreateTask
                  final body = {
                    "title": titleController.text,
                    "description": descriptionController.text,
                  };
                  getCreateTask(body);
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: Text('Create',style: const TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }
}