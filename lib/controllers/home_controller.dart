import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexter/models/resident_model.dart';
import 'package:dexter/models/shift_model.dart';
import 'package:dexter/models/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../styles/colors.dart';

class HomeController extends GetxController {
  late PageController controller;
  RxInt shiftDropdown = 1000.obs;
  RxInt residentDropdown = 1000.obs;
  final TextStyle mainTextStyle =
      const TextStyle(color: MyAppColors.black, fontFamily: 'SourceSansPro');
  RxString dateToday = ''.obs;
  RxString datePicker = ''.obs;
  RxString timePicker = ''.obs;
  RxString taskDate = ''.obs;
  RxInt dayNumber = 0.obs;
  RxInt addTaskName = 0.obs;
  DateTime today = DateTime.now();
  TextEditingController tasksController = TextEditingController();
  TextEditingController tasksDescriptionController = TextEditingController();
  @override
  void onInit() {
    dayNumber.value = today.weekday;
    dateToday.value = DateFormat('MMM d, y').format(DateTime.now().toLocal());
    getResidentsList();
    getShiftsList();
    getTasksList();
    super.onInit();
  }

  RxList<ResidentModel> residentsList = <ResidentModel>[].obs;
  RxList<TaskModel> tasksList = <TaskModel>[].obs;
  RxList<TaskModel> sortedList = <TaskModel>[].obs;
  RxList<ShiftModel> shiftsList = <ShiftModel>[].obs;
  void getResidentsList() {
    FirebaseFirestore.instance
        .collection('residents')
        .snapshots()
        .listen((event) {
      residentsList.value = [];
      for (var element in event.docs) {
        residentsList.add(ResidentModel.fromJson(element.data()));
      }
    });
  }

  void getTasksList() {
    FirebaseFirestore.instance
        .collection('tasks')
        .orderBy('task_date')
        .snapshots()
        .listen((event) {
      tasksList.value = [];

      for (var element in event.docs) {
        tasksList.add(TaskModel.fromJson(element.data()));
      }
      Future.delayed(const Duration(milliseconds: 500), () => sortListByDay());
    });
  }

  void getShiftsList() {
    FirebaseFirestore.instance.collection('shifts').snapshots().listen((event) {
      shiftsList.value = [];
      for (var element in event.docs) {
        shiftsList.add(ShiftModel.fromJson(element.data()));
      }
      shiftsList.sort((a, b) => a.shiftIndex.compareTo(b.shiftIndex));
    });
  }

  List<String> taskState = ['Todo', 'In progress', 'Done'];
  void addNewTask() async {
    if (residentDropdown.value != 1000 &&
        shiftDropdown.value != 1000 &&
        tasksController.text.isNotEmpty) {
      TaskModel taskModel = TaskModel(
        shiftModel: shiftsList[shiftDropdown.value],
        residentModel: residentsList[residentDropdown.value],
        taskName: tasksController.text,
        taskDescription: tasksDescriptionController.text,
        taskDate: taskDate.value,
        taskState: taskState.elementAt(0),
      );
      await FirebaseFirestore.instance
          .collection('tasks')
          .add({"id": "1"}).then((value) {
        taskModel.taskId = value.id;
        updateTask(task:taskModel ).then((value) {
          if (Get.isBottomSheetOpen ?? false) {
            Get.back();
          }
        }).catchError((onError){
          if (Get.isBottomSheetOpen ?? false) {
            Get.back();
          }
        });
      });
    }
  }

  void sortListByDay() {
    sortedList.value = [];
    update();
    for (var element in tasksList) {
      if (DateFormat("yyyy-MM-dd").format(DateTime.now()
              .add(Duration(days: (dayNumber.value - today.weekday)))) ==
          DateFormat("yyyy-MM-dd").format(DateTime.parse(element.taskDate))) {
        sortedList.add(element);

        ///If later want to remove Done tasks from the list
        // if(element.taskState!="Done"){
        //   sortedList.add(element);
        // }
      }
    }
  }

  Future<void> updateTask({
    required TaskModel task,
  }) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(task.taskId)
        .update(task.toJson());
  }
}
