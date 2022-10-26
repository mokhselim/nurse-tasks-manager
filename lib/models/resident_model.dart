class ResidentModel {
  String residentName = '';
  String residentId = '';
  String history = '';
  int residentRoomNumber = 0;

  ResidentModel({
    this.residentName = '',
    this.residentRoomNumber = 0,
    this.residentId = '',
    this.history = '',
  });
  ResidentModel.fromJson(Map<String, dynamic> json) {
    residentName = json['resident_name'] ?? '';
    residentRoomNumber = json['resident_room_number'] ?? 0;
    residentId = json['resident_id'] ?? '';
    history = json['history'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'resident_name': residentName,
      'resident_room_number': residentRoomNumber,
      'resident_id': residentId,
      'history': history,
    };
  }
}
