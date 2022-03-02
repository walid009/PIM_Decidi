import 'package:decidi/models/user.dart';

class Course {
  late String courseId;
  late String courseImage;
  late String courseTitle;
  late String courseDescription;
  late String coursePrice;
  late String courseCapacity;
  late String courseNbParticipant;
  late List<dynamic> courseListParticipants;

  Course(
      this.courseId,
      this.courseImage,
      this.courseTitle,
      this.courseDescription,
      this.coursePrice,
      this.courseCapacity,
      this.courseNbParticipant,
      this.courseListParticipants);
}
