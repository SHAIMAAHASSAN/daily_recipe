import 'package:untitled/untitled.dart';

void main(List<String> arguments) {
  //========Problem 1=================
  List<int> lessFive = [];
  List<int> lessFive2 = [];
  List<int> numberList1 = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89];
  for (int i = 0; i < numberList1.length; i++) {
    if (numberList1[i] < 5) {
      lessFive.add(numberList1[i]);
    }
  }

  //====== another way  using fo in ========
  for (int element in numberList1) {
    if (element < 5) lessFive2.add(element);
  }
  print("lessFive = $lessFive2");

  print("================= Solve of problem 1=====================");
  print("lessFive = $lessFive");

  ///////////////////////  problem 2 //////////////////////////
  List<int> numberList2 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
  List<int> commonElemnts = [];
  List<int> common = [];

  common = numberList1.toSet().intersection(numberList2.toSet()).toList();

  ///////////another way///////////
  for (int element in numberList2) {
    if (numberList1.contains(element)) {
      commonElemnts.add(element);
    }
  }

  print("================= Solve of problem 2=====================");

  print("common element using intersection = $common");
  print("common elements = $commonElemnts");

  ///////////////////////  problem 3 //////////////////////////
  List<int> listThree = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100];

  // var evenList=(listThree.where((element) => element%2==0)) ;
  var evenList = (listThree.where((element) => element.isEven));
  print("================= Solve of problem 3=====================");
  print(evenList.toList());

  ///////////////////////  Problem 4 ///////////////////////////
  List<int> a = [5, 10, 15, 20, 25];
  List<int> list = [1];
  List<int> newList = [];
  void getFirstAndLast(List<int> numbers) {
    if (numbers.length <= 1) {
      newList = numbers;
    } else {
      newList.add(numbers.first);
      newList.add(numbers.last);
    }
  }

  print("================= Solve of problem 4 =====================");
  //   if i have more one elements inside List like list a
  getFirstAndLast(a);
  print(newList);

  print("===========New value after change input argument==========");
  // if i have only one element like list

  getFirstAndLast(list);
  print(newList);
}
