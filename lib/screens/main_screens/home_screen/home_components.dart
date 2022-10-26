import 'package:dexter/models/resident_model.dart';
import 'package:dexter/models/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../controllers/home_controller.dart';
import '../../../shared/components/general_components.dart';
import '../../../styles/colors.dart';

class AddTaskBottomSheet extends StatelessWidget {
  final HomeController homeCtrl;
  const AddTaskBottomSheet({Key? key, required this.homeCtrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: homeCtrl.addTaskName.value != 0 ? 300 : 425,
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          decoration: BoxDecoration(
              color: MyAppColors.white,
              border: Border.all(color: MyAppColors.yellow, width: 1),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Column(
            children: [
              if (homeCtrl.addTaskName.value == 0)
                Column(
                  children: [
                    Text(
                      'Due Date',
                      style: homeCtrl.mainTextStyle
                          .copyWith(fontSize: 28, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      color: MyAppColors.grey,
                      height: 0,
                      thickness: 0.5,
                      endIndent: 30,
                      indent: 30,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SfDateRangePicker(
                      monthCellStyle: DateRangePickerMonthCellStyle(
                        todayTextStyle: homeCtrl.mainTextStyle
                            .copyWith(color: MyAppColors.black),
                      ),
                      selectionColor: MyAppColors.yellow,
                      backgroundColor: MyAppColors.white,
                      enablePastDates: false,
                      todayHighlightColor: MyAppColors.yellow,
                      selectionTextStyle: const TextStyle(color: Colors.black),
                      onSelectionChanged: (v) {
                        homeCtrl.datePicker.value = DateFormat("yyyy-MM-dd")
                            .format(DateTime.parse(v.value.toString()));
                        homeCtrl.addTaskName.value = 1;
                      },
                      selectionMode: DateRangePickerSelectionMode.single,
                    ),
                  ],
                ),
              if (homeCtrl.addTaskName.value == 2)
                Container(
                  height: 268,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  decoration: BoxDecoration(
                    color: MyAppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: MyAppColors.black.withOpacity(0.15),
                        offset: const Offset(0, 0),
                        blurRadius: 50,
                        spreadRadius: 0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: defaultTextFormField(
                                controller: homeCtrl.tasksController,
                                homeCtrl: homeCtrl),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: CustomDropdown(
                              index: homeCtrl.shiftDropdown,
                              key: UniqueKey(),
                              onChange: (Object change, int value) {},
                              homeCtrl: homeCtrl,
                              marginTop: 1,
                              height: 38,
                              small: true,
                              heightOffset: -109,
                              listRightMargin: (Get.width / 2) + 20,
                              items: homeCtrl.shiftsList
                                  .asMap()
                                  .entries
                                  .map(
                                    (item) => DropdownItem<int>(
                                      key: UniqueKey(),
                                      value: item.key + 1,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 4),
                                        child: Text(
                                          item.value.shiftName,
                                          style:
                                              homeCtrl.mainTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: MyAppColors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomDropdown(
                        index: homeCtrl.residentDropdown,
                        key: UniqueKey(),
                        onChange: (Object change, int value) {},
                        homeCtrl: homeCtrl,
                        marginTop: 0,
                        items: homeCtrl.residentsList
                            .asMap()
                            .entries
                            .map(
                              (item) => DropdownItem<int>(
                                key: UniqueKey(),
                                value: item.key + 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4),
                                  child: Text(
                                    item.value.residentName,
                                    style: homeCtrl.mainTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: MyAppColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: defaultTextFormField(
                              expand: true,
                              textKey: 'Description',
                              controller: homeCtrl.tasksDescriptionController,
                              homeCtrl: homeCtrl),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: MainButton(
                            homeCtrl: homeCtrl,
                            name: 'Add Task',
                            onTap: () {
                              homeCtrl.addNewTask();
                            }),
                      ),
                    ],
                  ),
                ),
              if (homeCtrl.addTaskName.value == 1)
                Column(
                  children: [
                    SizedBox(
                      height: 224,
                      child: CupertinoDatePicker(
                        use24hFormat: false,
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (DateTime value) {
                          homeCtrl.timePicker.value =
                              " ${DateFormat("HH:mm:ss.sss").format(DateTime.parse(value.toString()))}";
                          homeCtrl.taskDate.value = homeCtrl.datePicker.value +
                              homeCtrl.timePicker.value;
                        },
                      ),
                    ),
                    MainButton(
                        homeCtrl: homeCtrl,
                        name: 'Done',
                        icon: CupertinoIcons.check_mark,
                        onTap: () {
                          if (homeCtrl.timePicker.value.isEmpty) {
                            homeCtrl.timePicker.value =
                                " ${DateFormat("HH:mm:ss.sss").format(DateTime.now())}";
                          }
                          homeCtrl.taskDate.value = homeCtrl.datePicker.value +
                              homeCtrl.timePicker.value;

                          homeCtrl.addTaskName.value = 2;
                        }),
                  ],
                ),
            ],
          ),
        ));
  }
}

class MainButton extends StatelessWidget {
  final HomeController homeCtrl;
  final Function()? onTap;
  final String name;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final Color buttonColor;
  final double width;
  final double height;
  final double iconSize;
  final double textSize;
  const MainButton({
    Key? key,
    required this.homeCtrl,
    this.onTap,
    this.width = 110,
    this.height = 44,
    this.iconSize = 15,
    this.textSize = 14,
    this.name = 'Add tasks',
    this.icon = CupertinoIcons.add,
    this.iconColor = MyAppColors.white,
    this.textColor = MyAppColors.white,
    this.buttonColor = MyAppColors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              name,
              style: homeCtrl.mainTextStyle.copyWith(
                  fontSize: textSize,
                  fontWeight: FontWeight.w400,
                  color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

class SlideTask extends StatelessWidget {
  final Widget child;
  final TaskModel task;
  final HomeController homeCtrl;
  const SlideTask(
      {Key? key,
      required this.child,
      required this.task,
      required this.homeCtrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(task.taskId),
      closeOnScroll: false,
      endActionPane: ActionPane(
        extentRatio: 1 / 4.2,
        motion: const DrawerMotion(),
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if ((task.taskState == "In progress")) {
                      task.taskState = homeCtrl.taskState[0];
                    } else {
                      task.taskState = homeCtrl.taskState[1];
                    }
                    homeCtrl.updateTask(task: task);
                  },
                  child: Container(
                    width: 85.66,
                    height: 56,
                    decoration: BoxDecoration(
                      color: (task.taskState == "In progress")
                          ? Colors.red
                          : MyAppColors.yellow,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          (task.taskState == "In progress")
                              ? CupertinoIcons.timer
                              : CupertinoIcons.slowmo,
                          color: MyAppColors.black,
                        ),
                        Text(
                          (task.taskState == "In progress")
                              ? "Todo"
                              : 'In progress',
                          style: homeCtrl.mainTextStyle.copyWith(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.white,
                  height: 0,
                ),
                InkWell(
                  onTap: () {
                    task.taskState = homeCtrl.taskState[2];
                    homeCtrl.updateTask(task: task);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 85.66,
                    height: 59,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.9),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.check_mark_circled_solid,
                          color: MyAppColors.yellow,
                        ),
                        Text(
                          'Done',
                          style: homeCtrl.mainTextStyle.copyWith(
                              fontSize: 12, color: MyAppColors.yellow),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      child: child,
    );
  }
}

class ResidentsBottomSheet extends StatelessWidget {
  final HomeController homeCtrl;
  final ResidentModel resident;
  final int tasks;
  const ResidentsBottomSheet(
      {Key? key,
      required this.homeCtrl,
      required this.resident,
      required this.tasks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyAppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: MyAppColors.yellow),
        boxShadow: [
          BoxShadow(
            color: MyAppColors.black.withOpacity(0.09),
            offset: const Offset(0, 0),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Resident Name: ${resident.residentName}',
            style: homeCtrl.mainTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Room Number: ',
                style: homeCtrl.mainTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: 34,
                width: 70,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                    color: MyAppColors.yellow,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.house_outlined),
                    Text('${resident.residentRoomNumber}')
                  ],
                ),
              ),
            ],
          ),
          Text(
            'Tasks: $tasks',
            style: homeCtrl.mainTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
