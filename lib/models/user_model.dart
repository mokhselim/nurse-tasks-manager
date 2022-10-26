import 'package:dexter/models/shift_model.dart';

class UserModel {
  // ShiftModel userShift = ShiftModel();
  String userName = '';
  String userId = '';

  UserModel({
    // required this.userShift,
    required this.userName,
    required this.userId,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    // userShift = ShiftModel();
    // if (json['user_shift'] != null) {
    //   userShift = ShiftModel.fromJson(json['user_shift']);
    // }

    userName = json['user_name'] ?? 0;
    userId = json['user_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      // 'user_shift': userShift.toJson(),
      'user_name': userName,
      'user_id': userId,
    };
  }
}
