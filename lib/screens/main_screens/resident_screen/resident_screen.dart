import 'package:dexter/controllers/home_controller.dart';
import 'package:dexter/models/resident_model.dart';
import 'package:dexter/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import '../../../models/task_model.dart';
import '../home_screen/home_components.dart';

class ResidentScreen extends StatelessWidget {
  final HomeController homeCtrl;
  final ResidentModel resident;
  const ResidentScreen(
      {Key? key, required this.homeCtrl, required this.resident})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int tasks = 0;
    RxList<TaskModel> residentTasksList = <TaskModel>[].obs;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
                child: Text(
              resident.residentName,
              style: homeCtrl.mainTextStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )),
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'About ${resident.residentName} : ',
                            style: homeCtrl.mainTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        TextSpan(
                            text: resident.history,
                            style: homeCtrl.mainTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: MyAppColors.black.withOpacity(0.8))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Tasks : $tasks',
                      style: homeCtrl.mainTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Obx(() {
                    residentTasksList.value=[];
                    for (var element in homeCtrl.tasksList) {
                      if (resident.residentId == element.residentModel.residentId) {
                        residentTasksList.add(element);
                        tasks++;
                      }
                    }
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                        itemBuilder: (context, index) {
                          TaskModel task = residentTasksList[index];
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
                                          color:
                                          MyAppColors.black.withOpacity(0.09),
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
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            task.taskName,
                                            style: homeCtrl.mainTextStyle
                                                .copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                overflow:
                                                TextOverflow.ellipsis),
                                            maxLines: 1,
                                          ),
                                          Text(
                                            task.taskDescription,
                                            style: homeCtrl.mainTextStyle
                                                .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                overflow:
                                                TextOverflow.ellipsis,
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
                                                            : task.taskState ==
                                                            "Done"
                                                            ? Colors.green
                                                            : MyAppColors
                                                            .yellow,
                                                        shape: BoxShape.circle),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "Resident: ${task.residentModel.residentName}",
                                                style: homeCtrl.mainTextStyle
                                                    .copyWith(
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    color: MyAppColors.black
                                                        .withOpacity(0.8)),
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                DateFormat("HH:MM").format(
                                                    DateTime.parse(
                                                        task.taskDate)),
                                                style: homeCtrl.mainTextStyle
                                                    .copyWith(
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w500,
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
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4,
                                                    vertical: 2),
                                                decoration: BoxDecoration(
                                                    color: task.taskState ==
                                                        "Todo"
                                                        ? Colors.red
                                                        .withOpacity(0.5)
                                                        : task.taskState == "Done"
                                                        ? Colors.green
                                                        .withOpacity(0.5)
                                                        : MyAppColors.yellow
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                    BorderRadius.circular(8)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
                                                  children: [
                                                    const Icon(
                                                        Icons.house_outlined),
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
                        itemCount: residentTasksList.value.length);
                  }),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
