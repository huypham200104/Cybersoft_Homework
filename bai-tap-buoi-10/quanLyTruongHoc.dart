import 'dart:io';

class Person {
  int id;
  String name;
  int age;
  String gender;

  Person(this.id, this.name, this.age, this.gender);

}

class Student extends Person {
  String grade;
  final Map<String, double> subjectScores;

  Student(int id, String name, int age, String gender, this.grade,
      [Map<String, double>? scores])
      : subjectScores = scores ?? <String, double>{},
        super(id, name, age, gender);

  double get averageScore {
    if (subjectScores.isEmpty) {
      return 0;
    }
    final total = subjectScores.values.reduce((a, b) => a + b);
    return total / subjectScores.length;
  }

  void upsertScore(String subject, double score) {
    subjectScores[subject] = score;
  }

  void displayInfo() {
    final buffer = StringBuffer()
      ..write('ID: $id, Name: $name, Age: $age, Gender: $gender, Grade: $grade');
    if (subjectScores.isEmpty) {
      buffer.write(', Scores: chưa có dữ liệu');
    } else {
      buffer.write(', Scores: ');
      subjectScores.forEach((key, value) {
        buffer.write('$key=${value.toStringAsFixed(1)} ');
      });
      buffer.write(', Avg: ${averageScore.toStringAsFixed(2)}');
    }
    print(buffer.toString());
  }
}

class Teacher extends Person {
  String subject;
  double salary;

  Teacher(int id, String name, int age, String gender, this.subject, this.salary)
      : super(id, name, age, gender);

  void displayInfo() {
    print(
        'ID: $id, Name: $name, Age: $age, Gender: $gender, Subject: $subject, Salary: ${salary.toStringAsFixed(2)}');
  }
}

class Classroom {
  String id;
  String name;
  final List<Student> students;
  Teacher? teacher;

  Classroom(this.id, this.name)
      : students = <Student>[],
        teacher = null;

  void assignTeacher(Teacher newTeacher) {
    teacher = newTeacher;
  }

  void addStudent(Student student) {
    final exists = students.any((s) => s.id == student.id);
    if (exists) {
      print('Student ${student.name} đã có trong lớp $name.');
      return;
    }
    students.add(student);
  }

  void displayReport() {
    print('===== Lớp $name (ID: $id) =====');
    if (teacher == null) {
      print('Chưa có giáo viên phụ trách.');
    } else {
      print(
          'Giáo viên: ${teacher!.name} (${teacher!.subject}) - Lương: ${teacher!.salary.toStringAsFixed(2)}');
    }

    if (students.isEmpty) {
      print('Chưa có học sinh trong lớp.');
      return;
    }

    print('Danh sách học sinh và điểm trung bình:');
    for (final student in students) {
      final avg = student.averageScore.toStringAsFixed(2);
      print(' - ${student.name} (${student.grade}) => Avg: $avg');
      if (student.subjectScores.isNotEmpty) {
        student.subjectScores.forEach((subject, score) {
          print('    + $subject: ${score.toStringAsFixed(2)}');
        });
      }
    }
  }
}

class SchoolManager {
  final List<Student> _students = <Student>[];
  final List<Teacher> _teachers = <Teacher>[];
  final List<Classroom> _classrooms = <Classroom>[];

  void start() {
    while (true) {
      print('''\n===== QUẢN LÝ TRƯỜNG HỌC =====
1. Thêm học sinh
2. Thêm giáo viên
3. Tạo lớp học
4. Gán giáo viên vào lớp
5. Gán học sinh vào lớp
6. Cập nhật điểm cho học sinh
7. Xem báo cáo lớp học
8. Danh sách học sinh và điểm trung bình
9. Thoát\n''');
      stdout.write('Chọn chức năng: ');
      final input = stdin.readLineSync();
      switch (input) {
        case '1':
          _addStudent();
          break;
        case '2':
          _addTeacher();
          break;
        case '3':
          _createClassroom();
          break;
        case '4':
          _assignTeacherToClassroom();
          break;
        case '5':
          _assignStudentToClassroom();
          break;
        case '6':
          _updateStudentScore();
          break;
        case '7':
          _showClassroomReport();
          break;
        case '8':
          _listStudentsWithAverage();
          break;
        case '9':
          print('Tạm biệt!');
          return;
        default:
          print('Lựa chọn không hợp lệ.');
      }
    }
  }

  void _addStudent() {
    print('\n--- Nhập thông tin học sinh ---');
    final id = _readInt('ID');
    stdout.write('Tên: ');
    final name = stdin.readLineSync() ?? '';
    final age = _readInt('Tuổi');
    stdout.write('Giới tính: ');
    final gender = stdin.readLineSync() ?? '';
    stdout.write('Khối/Lớp: ');
    final grade = stdin.readLineSync() ?? '';

    final student = Student(id, name, age, gender, grade);
    _students.add(student);
    print('Thêm học sinh thành công.');
    _enterScoresForStudent(student);
  }

  void _addTeacher() {
    print('\n--- Nhập thông tin giáo viên ---');
    final id = _readInt('ID');
    stdout.write('Tên: ');
    final name = stdin.readLineSync() ?? '';
    final age = _readInt('Tuổi');
    stdout.write('Giới tính: ');
    final gender = stdin.readLineSync() ?? '';
    stdout.write('Bộ môn: ');
    final subject = stdin.readLineSync() ?? '';
    final salary = _readDouble('Lương');

    final teacher = Teacher(id, name, age, gender, subject, salary);
    _teachers.add(teacher);
    print('Thêm giáo viên thành công.');
  }

  void _createClassroom() {
    print('\n--- Tạo lớp học ---');
    stdout.write('Mã lớp: ');
    final id = stdin.readLineSync() ?? '';
    stdout.write('Tên lớp: ');
    final name = stdin.readLineSync() ?? '';

    final exists = _classrooms.any((c) => c.id == id);
    if (exists) {
      print('Mã lớp đã tồn tại.');
      return;
    }

    _classrooms.add(Classroom(id, name));
    print('Tạo lớp học thành công.');
  }

  void _assignTeacherToClassroom() {
    if (_teachers.isEmpty || _classrooms.isEmpty) {
      print('Cần có giáo viên và lớp học trước.');
      return;
    }
    final teacher = _selectTeacher();
    final classroom = _selectClassroom();
    if (teacher == null || classroom == null) {
      return;
    }
    classroom.assignTeacher(teacher);
    print('Đã gán ${teacher.name} vào lớp ${classroom.name}.');
  }

  void _assignStudentToClassroom() {
    if (_students.isEmpty || _classrooms.isEmpty) {
      print('Cần có học sinh và lớp học trước.');
      return;
    }
    final student = _selectStudent();
    final classroom = _selectClassroom();
    if (student == null || classroom == null) {
      return;
    }
    classroom.addStudent(student);
    print('Đã gán ${student.name} vào lớp ${classroom.name}.');
  }

  void _updateStudentScore() {
    if (_students.isEmpty) {
      print('Chưa có học sinh để cập nhật điểm.');
      return;
    }
    final student = _selectStudent();
    if (student == null) {
      return;
    }
    _enterScoresForStudent(student);
  }

  void _showClassroomReport() {
    if (_classrooms.isEmpty) {
      print('Chưa có lớp học nào.');
      return;
    }
    final classroom = _selectClassroom();
    classroom?.displayReport();
  }

  void _listStudentsWithAverage() {
    if (_students.isEmpty) {
      print('Chưa có học sinh nào.');
      return;
    }
    print('\n--- Danh sách học sinh ---');
    for (final student in _students) {
      final avg = student.averageScore.toStringAsFixed(2);
      print('${student.name} (ID: ${student.id}) - Avg: $avg');
    }
  }

  Student? _selectStudent() {
    stdout.write('Nhập ID học sinh: ');
    final idInput = stdin.readLineSync();
    final id = int.tryParse(idInput ?? '');
    if (id == null) {
      print('ID không hợp lệ.');
      return null;
    }
    final student = _students.firstWhere(
      (s) => s.id == id,
      orElse: () => Student(-1, '', 0, '', ''),
    );
    if (student.id == -1) {
      print('Không tìm thấy học sinh.');
      return null;
    }
    return student;
  }

  Teacher? _selectTeacher() {
    stdout.write('Nhập ID giáo viên: ');
    final idInput = stdin.readLineSync();
    final id = int.tryParse(idInput ?? '');
    if (id == null) {
      print('ID không hợp lệ.');
      return null;
    }
    final teacher = _teachers.firstWhere(
      (t) => t.id == id,
      orElse: () => Teacher(-1, '', 0, '', '', 0),
    );
    if (teacher.id == -1) {
      print('Không tìm thấy giáo viên.');
      return null;
    }
    return teacher;
  }

  Classroom? _selectClassroom() {
    stdout.write('Nhập mã lớp: ');
    final id = stdin.readLineSync();
    if (id == null || id.isEmpty) {
      print('Mã lớp không hợp lệ.');
      return null;
    }
    try {
      return _classrooms.firstWhere((c) => c.id == id);
    } catch (_) {
      print('Không tìm thấy lớp học.');
      return null;
    }
  }

  void _enterScoresForStudent(Student student) {
    print('Nhập điểm cho ${student.name} (để trống môn học nếu muốn dừng).');
    while (true) {
      stdout.write('Tên môn: ');
      final subject = stdin.readLineSync();
      if (subject == null || subject.trim().isEmpty) {
        break;
      }
      final score = _readDouble('Điểm');
      student.upsertScore(subject.trim(), score);
    }
  }

  int _readInt(String label) {
    while (true) {
      stdout.write('$label: ');
      final input = stdin.readLineSync();
      final value = int.tryParse(input ?? '');
      if (value != null) {
        return value;
      }
      print('Giá trị $label không hợp lệ, vui lòng nhập số.');
    }
  }

  double _readDouble(String label) {
    while (true) {
      stdout.write('$label: ');
      final input = stdin.readLineSync();
      final value = double.tryParse(input ?? '');
      if (value != null) {
        return value;
      }
      print('Giá trị $label không hợp lệ, vui lòng nhập số hợp lệ.');
    }
  }
}

void main() {
  final manager = SchoolManager();
  manager.start();
}