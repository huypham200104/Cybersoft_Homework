import 'dart:io';

class Employee {
  String name;
  int workingHours;
  double salaryPerHour;

  // Constructor
  Employee(this.name, this.workingHours, this.salaryPerHour);
}
double calculateTax(double totalSalary) {
  if (totalSalary < 7000000) {
    return 0;
  } else if (totalSalary < 10000000) {
    return totalSalary * 0.05; // 10% tax
  } else {
    return totalSalary * 0.1; // 20% tax
  }
}
void main() 
{
  print('Nhập tên nhân viên:');
  String name = stdin.readLineSync() ?? 'Không có tên';

  print('Nhập số giờ làm việc:');
  int workingHours = int.parse(stdin.readLineSync() ?? '0');

  print('Nhập mức lương theo giờ:');
  double salaryPerHour = double.parse(stdin.readLineSync() ?? '0');

  Employee employee = Employee(name, workingHours, salaryPerHour);
  double totalSalary = employee.workingHours * employee.salaryPerHour;

  double tax = calculateTax(totalSalary);
  double netSalary = totalSalary - tax;
  print('Tên nhân viên: ${employee.name}');
  print('Tổng lương: $totalSalary');
  print('Thuế phải nộp: $tax');
  print('Lương sau thuế: $netSalary');
  
}