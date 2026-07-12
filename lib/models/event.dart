class Event {
  int? id;
  String eventName;
  int eventNumber;
  String date;
  String venue;
  String startTime;
  String endTime;
  String theme;
  int maxPerformers;
  int maxGuests;
  String status;
  String remarks;

  Event({
    this.id,
    required this.eventName,
    required this.eventNumber,
    required this.date,
    required this.venue,
    required this.startTime,
    required this.endTime,
    required this.theme,
    required this.maxPerformers,
    required this.maxGuests,
    required this.status,
    required this.remarks,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventName': eventName,
      'eventNumber': eventNumber,
      'date': date,
      'venue': venue,
      'startTime': startTime,
      'endTime': endTime,
      'theme': theme,
      'maxPerformers': maxPerformers,
      'maxGuests': maxGuests,
      'status': status,
      'remarks': remarks,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      eventName: map['eventName'],
      eventNumber: map['eventNumber'],
      date: map['date'],
      venue: map['venue'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      theme: map['theme'],
      maxPerformers: map['maxPerformers'],
      maxGuests: map['maxGuests'],
      status: map['status'],
      remarks: map['remarks'],
    );
  }
}