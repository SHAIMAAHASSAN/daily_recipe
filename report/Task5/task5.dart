

void main(List<String> arguments) {
  Merrcides merrcides = Merrcides();
  merrcides.color();

  Merrcides.engine ="CC1400";
  print("Engine : ${Merrcides.engine}");
  //can access it through get function
  merrcides.engineType= "CC1300";
  merrcides.engineType;
  print("Engine Type : ${merrcides.engineType}");
  merrcides.fuelType="Natural-Gas"; //Encapulation
  merrcides.fuelType;
  print("Fuel Type : ${merrcides.fuelType}");

}
class Merrcides extends Car {
  static String engine = "CC1600";
  // setter and getter for static variable
  String  get engineType =>engine;
  set engineType(String engineType)=>engine=engineType;
  // setter and getter for private value
  String _fuel = "Hagen";
  String get fuelType =>_fuel;
  set fuelType (String fuelType)=>_fuel =fuelType;

  @override
  void color() {
    // TODO: implement color
    print("My Favourite  car is Green");
    super.color();
  }
}
 abstract class Car {
  void color(){
    String name= "Merrcides";
    print("Color of car : ${name} is red");
  }

  
}

