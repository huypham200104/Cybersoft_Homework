import 'dart:io';

class Student {
    String name;
    double mathScrore;
    double physicsScore;
    double chemistryScore;

    Student(this.name, this.mathScrore, this.physicsScore, this.chemistryScore);

    void displayInfo() {
        print("Name: $name");
        print("Math Score: $mathScrore");
        print("Physics Score: $physicsScore");
        print("Chemistry Score: $chemistryScore");
    }
}

Student findStudentWithHighestAverage(List<Student> students) {
    Student topStudent = students[0];
    double highestAverage = (students[0].mathScrore + students[0].physicsScore + students[0].chemistryScore) / 3;

    for (int i = 1; i < students.length; i++) {
        double average = (students[i].mathScrore + students[i].physicsScore + students[i].chemistryScore) / 3;
        if (average > highestAverage) {
            highestAverage = average;
            topStudent = students[i];
        }
    }
    return topStudent;
}

void main()
{
    List<Student> students = [
        Student("Nguyen Van A", 8.5, 7.0, 9.0),
        Student("Le Thi B", 6.0, 8.5, 7.5),
        Student("Tran Van C", 9.0, 9.5, 8.0),
    ];
    for(int i = 0; i < students.length; i++) {
        print("Student ${i + 1}:");
        students[i].displayInfo();
        print("");
    }

    Student topStudent = findStudentWithHighestAverage(students);
    print("Student with the highest average score:");
    topStudent.displayInfo();
}