import 'dart:convert';
import 'dart:io';

class Student {
  final int id;
  final String name;
  final List<double> scores;
  final List<String> courses;

  Student({
    required this.id,
    required this.name,
    required this.scores,
    required this.courses,
  });
}

void main() {
  // Đọc dữ liệu từ tệp JSON (nếu có)
  File file = File('Student.json');
  String jsonStr = file.readAsStringSync();
  List<dynamic> studentData = json.decode(jsonStr);

  // Chuyển đổi dữ liệu thành danh sách các đối tượng sinh viên
  List<Student> students = studentData.map((data) {
    return Student(
      id: data['id'],
      name: data['name'],
      scores: List<double>.from(data['scores']),
      courses: List<String>.from(data['courses']),
    );
  }).toList();

  // Hiển thị toàn bộ danh sách sinh viên
  print('Danh sách sinh viên:');
  students.forEach((student) {
    print(
        'ID: ${student.id}, Tên: ${student.name}, Điểm: ${student.scores}, Môn học: ${student.courses}');
  });

  // Nhập tên của sinh viên cần tìm kiếm
  print('Nhập tên sinh viên cần tìm kiếm:');
  String searchName = stdin.readLineSync()!;

  // Tìm sinh viên theo tên
  List<Student> foundStudents = students
      .where(
        (student) =>
            student.name.toLowerCase().contains(searchName.toLowerCase()),
      )
      .toList();

  if (foundStudents.isNotEmpty) {
    print('Sinh viên có tên $searchName là:');
    foundStudents.forEach((student) {
      print('ID: ${student.id}, Tên: ${student.name}');
    });
  } else {
    print('Không tìm thấy sinh viên với tên $searchName');
  }

  // Nhập thông tin sinh viên mới
  print('Nhập thông tin sinh viên mới:');
  print('ID:');
  int newId = int.parse(stdin.readLineSync()!);
  print('Tên:');
  String newName = stdin.readLineSync()!;
  print('Điểm (cách nhau bằng dấu phẩy):');
  List<double> newScores = stdin
      .readLineSync()!
      .split(',')
      .map((score) => double.parse(score))
      .toList();
  print('Môn học (cách nhau bằng dấu phẩy):');
  List<String> newCourses = stdin.readLineSync()!.split(',');

  // Thêm sinh viên mới
  students.add(Student(
    id: newId,
    name: newName,
    scores: newScores,
    courses: newCourses,
  ));

  // Ghi danh sách sinh viên vào tệp JSON
  String updatedJsonStr = json.encode(students);
  file.writeAsStringSync(updatedJsonStr);
  print('Dữ liệu đã được ghi vào tệp Student.json');
}
