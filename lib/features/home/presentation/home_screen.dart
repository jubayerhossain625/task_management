import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task_management/common/widgets/custom_image_view.dart';
import 'package:task_management/common/widgets/custom_text_view.dart';
import 'package:task_management/core/data/local_data/local_storage_source.dart';
import 'package:task_management/features/home/controllers/home_controller.dart';
import 'package:task_management/util/app_constants.dart';
import '../../../core/routes/routes.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                        padding: const EdgeInsets.only(top: 35.0, left: 12, right: 12),
                        child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [

                    Expanded(

                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.profile);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 45,
                              width: 45,
                              child: CustomImageView(
                                imageType: CustomImageType.network,
                                imageData: controller.myProfile.value?.data?.address??"",
                                clipBorderRadius: 100,
                                boxFit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextView(
                                  text:"${ controller.myProfile.value?.data?.firstName??""} ${controller.myProfile.value?.data?.lastName??""}",
                                  textViewStyle: CustomTextViewStyle.medium,
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomTextView(
                                  text: controller.myProfile.value?.data?.email??"",
                                  textViewStyle: CustomTextViewStyle.medium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        LocalStorage.remove(AppConstants.token);
                        LocalStorage.eraseAll();
                        Get.offAllNamed(Routes.login);
                      },
                      child: const Column(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.indigo,
                          ),
                          CustomTextView(
                            text: "Logout",
                            textViewStyle: CustomTextViewStyle.small,
                            fontWeight: FontWeight.w600,
                            textColor: Colors.indigo,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomTextView(
                  text: "TaskList:",
                  textViewStyle: CustomTextViewStyle.medium,
                ),
                Divider(
                  color: Colors.grey.shade300,
                ),
                const SizedBox(
                  height: 0,
                ),
              StaggeredGrid.count(
                    crossAxisCount: (Get.width > 600 ? 2 : 1),
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: List.generate(
                        controller.allTask.value?.data?.myTasks?.length ?? 0,
                        (index) {
                      final item = controller.allTask.value?.data?.myTasks?[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextView(
                                  text: item?.title ?? "",
                                  textViewStyle: CustomTextViewStyle.medium,
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomTextView(
                                  text: item?.description ?? "",
                                  textViewStyle: CustomTextViewStyle.medium,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomTextView(
                                            text:
                                            "Created At:${AppConstants().formatDate(item?.createdAt?.toIso8601String())}",
                                            textViewStyle: CustomTextViewStyle.small,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          CustomTextView(
                                            text:
                                            "Update At:${AppConstants().formatDate(item?.createdAt?.toIso8601String())}",
                                            textViewStyle: CustomTextViewStyle.small,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDeleteDialog(context, item?.id ?? "");
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.trashCan,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ]),
                        ),
                      );
                    }),
                  ),
                const SizedBox(height: 140,)
              ],
                        ),

                      ),
            ),
          floatingActionButton: FloatingActionButton(onPressed: (){
            Get.find<HomeController>().showCreateTaskDialog(context);
          },child: const Icon(Icons.add,color: Colors.white,),),

        );
      }
    );
  }

  void showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete Task'),
            ],
          ),
          content: const Text(
            'Are you sure you want to delete this item?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Get.find<HomeController>().getDeleteTask(id);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Delete',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
