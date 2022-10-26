class ShiftModel {
  String shiftName = '';
  String shiftStartingTime = '';
  String shiftEndingTime = '';
  int shiftIndex = 0;

  ShiftModel({
    this.shiftName = '',
    this.shiftIndex = 0,
    this.shiftStartingTime = '',
    this.shiftEndingTime = '',
  });

  ShiftModel.fromJson(Map<String, dynamic> json) {
    shiftName = json['shift_name'] ?? '';
    shiftIndex = json['shift_index'] ?? 0;
    shiftStartingTime = json['shift_starting_time'] ?? '';
    shiftEndingTime = json['shift_ending_time'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'shift_name': shiftName,
      'shift_index': shiftIndex,
      'shift_starting_time': shiftStartingTime,
      'shift_ending_time': shiftEndingTime,
    };
  }
}
