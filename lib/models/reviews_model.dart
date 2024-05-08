class ReviewModel {
  final String userId;
  final String reviewTitle;
  final String review;
  final String starrateing;
  final DateTime time;
  ReviewModel({
    required this.userId,
    required this.reviewTitle,
    required this.review,
    required this.starrateing,
    required this.time,
  });
  

  ReviewModel copyWith({
    String? userId,
    String? reviewTitle,
    String? review,
    String? starrateing,
    DateTime? time,
  }) {
    return ReviewModel(
      userId: userId ?? this.userId,
      reviewTitle: reviewTitle ?? this.reviewTitle,
      review: review ?? this.review,
      starrateing: starrateing ?? this.starrateing,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'reviewTitle': reviewTitle,
      'review': review,
      'starrateing': starrateing,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      userId: map['userId'] as String,
      reviewTitle: map['reviewTitle'] as String,
      review: map['review'] as String,
      starrateing: map['starrateing'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }
}
