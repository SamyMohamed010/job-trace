import 'dart:typed_data';

class StudentService {
  static final StudentService _instance = StudentService._internal();
  factory StudentService() => _instance;
  StudentService._internal();

  String name = "Ahmed Khalid";
  String email = "student@example.com";
  String faculty = "Ain Shams University";
  String major = "Computer Science";
  String year = "2026";
  List<String> skills = ["Teamwork", "Java", "Data analysis", "Critical thinking", "Time management", "Excel", "soft skills", "Laboratory techniques"];
  String? cvFileName;
  String profileImage = "assets/images/pro.jpg"; 
  Uint8List? profileImageBytes; // To store picked image from web/mobile
  String about = "Passionate Computer Science student with a focus on Flutter development. Eager to learn and contribute to innovative projects.";
}

final studentService = StudentService();
