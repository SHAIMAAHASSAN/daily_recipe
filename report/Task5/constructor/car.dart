import 'dart:math';

class Car {
  String typeName;
  String color;
  String engine;
  int? numberSeats;


  Car({required this.typeName,
    required this.color,
    required this.engine,
     this.numberSeats,});

  void printData (){

    print("Car Name :$typeName");
    print("Car Color :$color");
    print("Car Engine :$engine");
    print("Car NoOfSeats :$numberSeats");
  }




}

   class CarPayment {
     double _price = 0.0;
     double get price => _price;

     CarPayment ({ double price = 0}) :_price=price;

     double calculateSpeed(double distance, double time) {
       if (time == 0) {
         throw ArgumentError("Time cannot be zero.");
       }

       return distance / time;
     }

   }
    class CarNeedsPayment  extends CarPayment{
      double _interestRate = 0;
       int loanTermInMonths =60;
       CarNeedsPayment ({double interestValue=0,super.price}):_interestRate =interestValue;

      double calculateMonthlyPayment(double price, double interestRate, int loanTermInMonths) {
        // Ensure interest rate is in decimal form (e.g., 5% = 0.05).
        interestRate /= 100;

        // Calculate the monthly interest rate.
        double monthlyInterestRate = interestRate / 12;

        // Apply the loan payment formula.
        return (price * monthlyInterestRate) /
            (1 - pow(1 + monthlyInterestRate, -loanTermInMonths));
      }


     @override
  double calculateSpeed(double distance, double time) {
        print("Speed of car = ${distance/time}");
    // TODO: implement calculateSpeed
    return super.calculateSpeed(distance, time);

  }


   }

  // optimum constructor with properties
  /*final String typeName;
  final String color;
  final String engine;
  final int numberSeats;
  final double? _price = 0.0;
  const Car(
      {required this.typeName,
      required this.color,
      required this.engine,
      required this.numberSeats});*/




