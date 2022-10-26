import 'package:dexter/models/resident_model.dart';
import 'package:dexter/models/shift_model.dart';

class TaskModel {
  String taskName = '';
  String taskDescription = '';
  String taskDate = '';
  String taskState = '';
  String taskId = '';
  ShiftModel shiftModel = ShiftModel();
  ResidentModel residentModel = ResidentModel();

  TaskModel({
    this.taskName = '',
    this.taskDescription = '',
    this.taskDate = '',
    this.taskState = '',
    this.taskId = '',
    required this.shiftModel,
    required this.residentModel,
  });
  TaskModel.fromJson(Map<String, dynamic> json) {
    taskName = json['task_name'] ?? '';
    taskId = json['task_id'] ?? '';
    taskDescription = json['task_description'] ?? '';
    taskState = json['task_state'] ?? '';
    taskDate = json['task_date'] ?? '';
    if (json['shift'] != null) {
      shiftModel = ShiftModel.fromJson(json['shift']);
    }
    if (json['resident'] != null) {
      residentModel = ResidentModel.fromJson(json['resident']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'task_name': taskName,
      'task_id': taskId,
      'task_description': taskDescription,
      'task_state': taskState,
      'task_date': taskDate,
      'shift': shiftModel.toJson(),
      'resident': residentModel.toJson(),
    };
  }
}
