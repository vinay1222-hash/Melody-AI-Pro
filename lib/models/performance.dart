class Performance {
  int? id;

  int eventId;
  int memberId;

  String songName;
  String movieName;
  String originalSinger;
  String musicDirector;
  String language;

  String performanceType; // Solo / Duet / Group

  int? partnerMemberId;

  int roundNumber;
  int performanceOrder;

  String karaokeLink;
  String youtubeLink;
  String remarks;

  String status;

  Performance({
    this.id,
    required this.eventId,
    required this.memberId,
    required this.songName,
    required this.movieName,
    required this.originalSinger,
    required this.musicDirector,
    required this.language,
    required this.performanceType,
    this.partnerMemberId,
    required this.roundNumber,
    required this.performanceOrder,
    required this.karaokeLink,
    required this.youtubeLink,
    required this.remarks,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventId': eventId,
      'memberId': memberId,
      'songName': songName,
      'movieName': movieName,
      'originalSinger': originalSinger,
      'musicDirector': musicDirector,
      'language': language,
      'performanceType': performanceType,
      'partnerMemberId': partnerMemberId,
      'roundNumber': roundNumber,
      'performanceOrder': performanceOrder,
      'karaokeLink': karaokeLink,
      'youtubeLink': youtubeLink,
      'remarks': remarks,
      'status': status,
    };
  }

  factory Performance.fromMap(Map<String, dynamic> map) {
    return Performance(
      id: map['id'],
      eventId: map['eventId'],
      memberId: map['memberId'],
      songName: map['songName'],
      movieName: map['movieName'],
      originalSinger: map['originalSinger'],
      musicDirector: map['musicDirector'],
      language: map['language'],
      performanceType: map['performanceType'],
      partnerMemberId: map['partnerMemberId'],
      roundNumber: map['roundNumber'],
      performanceOrder: map['performanceOrder'],
      karaokeLink: map['karaokeLink'],
      youtubeLink: map['youtubeLink'],
      remarks: map['remarks'],
      status: map['status'],
    );
  }
}