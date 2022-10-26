import 'package:dexter/models/resident_model.dart';
import 'package:dexter/models/task_model.dart';
import 'package:dexter/screens/main_screens/resident_screen/resident_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/home_controller.dart';
import '../../../styles/colors.dart';
import 'home_components.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeCtrl;
  const HomeScreen({Key? key, required this.homeCtrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homeCtrl.dateToday.value,
                    style: homeCtrl.mainTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: MyAppColors.black.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Today',
                    style: homeCtrl.mainTextStyle
                        .copyWith(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              MainButton(
                  homeCtrl: homeCtrl,
                  onTap: () {
                    homeCtrl.addTaskName.value = 0;
                    homeCtrl.residentDropdown.value = 1000;
                    homeCtrl.shiftDropdown.value = 1000;
                    homeCtrl.tasksController.clear();
                    homeCtrl.tasksDescriptionController.clear();
                    homeCtrl.datePicker.value = '';
                    homeCtrl.timePicker.value = '';
                    Get.bottomSheet(AddTaskBottomSheet(
                      homeCtrl: homeCtrl,
                    ));
                  }),
            ],
          ),
        ),
        Obx(() => Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) {
                  String day = '';
                  int date = 1;
                  switch (index) {
                    case 0:
                      {
                        day = "Mon";
                        date = dateCalculate(index);

                        break;
                      }
                    case 1:
                      {
                        day = "Tue";
                        date = dateCalculate(index);
                        break;
                      }
                    case 2:
                      {
                        day = "Wed";
                        date = dateCalculate(index);
                        break;
                      }
                    case 3:
                      {
                        day = "Thu";
                        date = dateCalculate(index);
                        break;
                      }
                    case 4:
                      {
                        day = "Fri";
                        date = dateCalculate(index);
                        break;
                      }
                    case 5:
                      {
                        day = "Sat";
                        date = dateCalculate(index);
                        break;
                      }
                    case 6:
                      {
                        day = "Sun";
                        date = dateCalculate(index);
                        break;
                      }
                  }
                  return Expanded(
                    child: InkWell(
                      onTap: () {
                        homeCtrl.dayNumber.value = index + 1;
                        homeCtrl.sortListByDay();
                      },
                      child: SizedBox(
                        height: 54,
                        child: Column(
                          children: [
                            Text(
                              day,
                              style: homeCtrl.mainTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight:
                                    homeCtrl.dayNumber.value == index + 1
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                color: homeCtrl.dayNumber.value == index + 1
                                    ? MyAppColors.yellow
                                    : MyAppColors.black.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(date.toString(),
                                style: homeCtrl.mainTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight:
                                        homeCtrl.dayNumber.value == index + 1
                                            ? FontWeight.w700
                                            : FontWeight.w600,
                                    color: homeCtrl.dayNumber.value == index + 1
                                        ? MyAppColors.yellow
                                        : MyAppColors.black)),
                            if (homeCtrl.dayNumber.value == index + 1)
                              Container(
                                height: 4,
                                width: 4,
                                margin: const EdgeInsets.only(top: 2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: MyAppColors.yellow,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
        //   child: MainButton(
        //     width: double.infinity,
        //     buttonColor: MyAppColors.yellow,
        //     icon:CupertinoIcons.person_3,
        //     iconColor: MyAppColors.black,
        //     textColor: MyAppColors.black,
        //     iconSize: 30,
        //     textSize: 16,
        //     name: 'Residents',
        //
        //     onTap: (){}, homeCtrl: homeCtrl,
        //   ),
        // ),
        Container(
          height: 75,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          decoration: BoxDecoration(
            color: MyAppColors.white,
            border: Border.all(color: MyAppColors.yellow),
            boxShadow: [
              BoxShadow(
                color: MyAppColors.black.withOpacity(0.15),
                offset: const Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            onTap: () {
              Get.bottomSheet(
                  SafeArea(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: MyAppColors.white,
                          border: Border.all(color: MyAppColors.black),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10),
                            child: Text(
                              'Residents: ${homeCtrl.residentsList.length}',
                              style: homeCtrl.mainTextStyle.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                ),
                                itemBuilder: (context, index) {
                                  List<ResidentModel> list =
                                      homeCtrl.residentsList;
                                  list.sort((a, b) => a.residentRoomNumber
                                      .compareTo(b.residentRoomNumber));
                                  ResidentModel resident = list[index];
                                  int tasks = 0;
                                  for (var element in homeCtrl.tasksList) {
                                    if (resident.residentId ==
                                        element.residentModel.residentId) {
                                      tasks++;
                                    }
                                  }
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => ResidentScreen(
                                          homeCtrl: homeCtrl,
                                          resident: resident));
                                    },
                                    child: ResidentsBottomSheet(
                                      homeCtrl: homeCtrl,
                                      resident: resident,
                                      tasks: tasks,
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount: homeCtrl.residentsList.length),
                          ),
                        ],
                      ),
                    ),
                  ),
                  isScrollControlled: false);
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Residents',
                        style: homeCtrl.mainTextStyle.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text('View all residents list',
                          style: homeCtrl.mainTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyAppColors.grey)),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                      color: MyAppColors.yellow,
                      borderRadius: BorderRadius.circular(7)),
                  child: const Icon(CupertinoIcons.person_3_fill),
                ),
              ],
            ),
          ),
        ),

        ///Tasks List
        Obx(() => Expanded(
              child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 15,
                    );
                  },
                  itemBuilder: (context, index) {
                    TaskModel task = homeCtrl.sortedList[index];
                    return SlideTask(
                      task: task,
                      homeCtrl: homeCtrl,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          ///Task Container
                          Container(
                            height: 115,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: MyAppColors.black.withOpacity(0.09),
                                    offset: const Offset(0, 0),
                                    blurRadius: 20,
                                    spreadRadius: 0,
                                  ),
                                ],
                                color: MyAppColors.white,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.taskName,
                                      style: homeCtrl.mainTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 1,
                                    ),
                                    Text(
                                      task.taskDescription,
                                      style: homeCtrl.mainTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                          color: MyAppColors.grey),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Status : ${task.taskState}",
                                              style: homeCtrl.mainTextStyle
                                                  .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                              maxLines: 1,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 5),
                                              height: 6,
                                              width: 6,
                                              decoration: BoxDecoration(
                                                  color: task.taskState ==
                                                          "Todo"
                                                      ? Colors.red
                                                          .withOpacity(0.8)
                                                      : task.taskState == "Done"
                                                          ? Colors.green
                                                          : MyAppColors.yellow,
                                                  shape: BoxShape.circle),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Resident: ${task.residentModel.residentName}",
                                          style: homeCtrl.mainTextStyle
                                              .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: MyAppColors.black
                                                      .withOpacity(0.8)),
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),

                                    ///Room Number Row
                                    Row(
                                      children: [
                                        Text(
                                          DateFormat("HH:MM").format(
                                              DateTime.parse(task.taskDate)),
                                          style: homeCtrl.mainTextStyle
                                              .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: MyAppColors.black
                                                      .withOpacity(0.8)),
                                          maxLines: 1,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Container(
                                          height: 34,
                                          width: 70,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 2),
                                          decoration: BoxDecoration(
                                              color: task.taskState == "Todo"
                                                  ? Colors.red.withOpacity(0.5)
                                                  : task.taskState == "Done"
                                                      ? Colors.green
                                                          .withOpacity(0.5)
                                                      : MyAppColors.yellow
                                                          .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const Icon(Icons.house_outlined),
                                              Text(
                                                  '${task.residentModel.residentRoomNumber}')
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                          ///Banner on right
                          Container(
                            width: 8,
                            height: 115,
                            decoration: BoxDecoration(
                                color: task.taskState == "Todo"
                                    ? Colors.red.withOpacity(1)
                                    : task.taskState == "Done"
                                        ? Colors.green
                                        : MyAppColors.yellow,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: homeCtrl.sortedList.length),
            ))
      ],
    );
  }

  int dateCalculate(int index) {
    if (index + 1 == homeCtrl.today.weekday) {
      return homeCtrl.today.day;
    } else if (index + 1 < homeCtrl.today.weekday) {
      return homeCtrl.today
          .subtract(Duration(days: homeCtrl.today.weekday - (index + 1)))
          .day;
    } else {
      return homeCtrl.today
          .add(Duration(days: index - (homeCtrl.today.weekday - 1)))
          .day;
    }
  }
}
