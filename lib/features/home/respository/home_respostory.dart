import 'dart:convert';

import 'package:task_management/util/app_constants.dart';

import '../../../core/services/api_client_implemnt.dart';
import '../model/create_task_resposeModel.dart';
import '../model/delete_task_response_model.dart';
import '../model/my_profile.dart';
import '../model/task_list_response_model.dart';

class HomeRepository{

final clientApi = APIClintImpl();

  Future<TaskListResponseModel?> getTaskList()async{
    dynamic response = await clientApi.get(AppConstants.getAllTaskUri);
    return response!=null?TaskListResponseModel.fromJson(response):null;
  }
  Future<MyProfileResponseModel?> getMyProfile()async{
    dynamic response = await clientApi.get(AppConstants.getMyProfileUri);
    return response!=null?MyProfileResponseModel.fromJson(response):null;
  }

  Future<TaskDeleteResponseModel?> deleteTask(id)async{
    dynamic response = await clientApi.delete("${AppConstants.deleteTaskUri}/$id");
    return response!=null?TaskDeleteResponseModel.fromJson(response):null;
  }

Future<TaskCreateResponseModel?> createTask(body)async{
  dynamic response = await clientApi.post(AppConstants.createTaskUri,data: jsonEncode(body));
  return response!=null? TaskCreateResponseModel.fromJson(response):null;
}


}