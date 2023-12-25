//import 'package:untitled/untitled.dart';



import 'car.dart';

void main(List<String> arguments) {
  var car1 = Car(
      typeName: "Mercedes", color: "yellow", engine: "CC1500", numberSeats: 7);
  var car2 = Car(typeName: "KIA", color: "red", engine: "CC1600");
  car1.printData();
  car2.printData();

  var carPayment = CarPayment(price: 40.000);
  double carSpeed = carPayment.calculateSpeed(50, 120);
  print(carSpeed);

  var carNeeds = CarNeedsPayment(interestValue: 30, price: 500.000);
  double loan = carNeeds.calculateMonthlyPayment(500.00, 30, 40);
  print(loan);
  carNeeds.calculateSpeed(40, 14);
}