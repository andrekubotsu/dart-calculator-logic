import 'dart:io';

void main() {
  var teste = stdin.readLineSync();
  teste = teste.toString();

  calculator(teste);

  // var calc = -100 - 10;
  // print(calc);
}

RegExp regexDivOperation = RegExp(r"(^([\-0-9.]+)\/([0-9.]+))");
RegExp regexMultOperation = RegExp(r"(^([\-0-9.]+)\*([0-9.]+))");
RegExp regexSumOperation = RegExp(r"(^([\-0-9.]+)\+([0-9.]+))");
RegExp regexMinusOperation = RegExp(r"(^([\-0-9.]+)\-([0-9.]+))");

RegExp regexPercentSingle = RegExp(r"(^([0-9.]+)\%)");

RegExp regexDivPercentOperators = RegExp(r"[\/\%]");
RegExp regexMultPercentOperators = RegExp(r"[\*\%]");
RegExp regexSumPercentOperators = RegExp(r"[\+\%]");
RegExp regexMinusPercentOperators = RegExp(r"[\-\%]");

RegExp regexHasAnyOperation = RegExp(r"(^([\-0-9.]+)[\-\+\*\/]([0-9.]+))");

RegExp regexDivOperator = RegExp(r"[\/]");
RegExp regexMultOperator = RegExp(r"[\*]");
RegExp regexSumOperator = RegExp(r"[\+]");
RegExp regexMinusOperator = RegExp(r"\-(?!.*\-)");
RegExp regexPecentOperator = RegExp(r"[\%]");

// to check presence of operation: true or false
RegExp regexMultDivOperators = RegExp(r"[\*\/]");
RegExp regexSumSubOperators = RegExp(r"[\+\-]");

//TODO: operações com porcentagem

singleOperation(
  String results,
  RegExp operationRegex,
  RegExp operatorRegex,
  RegExp operatorPercentRegex,
  operationFunction,
) {
  String match = '';
  double result;

  String currentOperaton = results;
  Iterable<Match> matches = operationRegex.allMatches(currentOperaton);
  for (var m in matches) {
    match = m[0]!;
  }

  var numbers = match.split(operatorRegex);

  print(numbers);

  var a = double.tryParse(numbers[0]);
  var b = double.tryParse(numbers[1]);

  print(a);
  print(b);

  if (a != null && b != null) {
    result = operationFunction(a, b);
    results = results.replaceAll(operationRegex, result.toString());
    print(results);

    return results;
  } else {
    print("Algo deu errado!");
  }
}

calculator(operation) {
  String results = operation;
  // First check if it has * and/or /
  bool checkMultDivPresence;
  do {
    int multIndex;
    int divIndex;
    checkMultDivPresence = toBeChecked(regexMultDivOperators, results);
    if (checkMultDivPresence == true) {
      // now check what cames first (from left to right)
      multIndex = results.indexOf("*"); // indexOf returns the first index;
      divIndex = results.indexOf("/");

      print(multIndex);
      print(divIndex);

      if (multIndex > -1 && divIndex > multIndex || divIndex == -1) {
        print("vamos multiplicar primeiro");

        // bool checkMultOperation = toBeChecked(regexMultOperation, results);
        // if (checkMultOperation) {
        results = singleOperation(results, regexMultOperation,
            regexMultOperator, regexMultPercentOperators, mult);
        //}
      } else {
        print("vamos dividir primeiro");

        // bool checkDivOperation = toBeChecked(regexDivOperation, results);
        // if (checkDivOperation) {
        results = singleOperation(results, regexDivOperation, regexDivOperator,
            regexDivPercentOperators, div);
        //}
      }
    }
  } while (checkMultDivPresence == true);

  bool checkSumSubPresence;

  do {
    int sumIndex;
    int subIndex;
    checkSumSubPresence = toBeChecked(regexSumSubOperators, results);
    if (checkSumSubPresence == true) {
      // now check what cames first (from left to right)
      sumIndex = results.indexOf("+"); // indexOf returns the first index;
      subIndex = results.indexOf("-");

      print(sumIndex);
      print(subIndex);

      if (sumIndex > -1 && subIndex > sumIndex ||
          subIndex == -1 ||
          subIndex == 0) {
        print("vamos somar primeiro");

        // bool checkSumOperation = toBeChecked(regexSumOperation, results);
        // if (checkSumOperation) {
        results = singleOperation(results, regexSumOperation, regexSumOperator,
            regexSumPercentOperators, sum);
        //}

      } else {
        print("vamos subtrair primeiro");

        // bool checkMinusOperation = toBeChecked(regexMinusOperation, results);
        // if (checkMinusOperation) {
        results = singleOperation(results, regexMinusOperation,
            regexMinusOperator, regexMultPercentOperators, sub);
        //}

      }
    }
  } while (checkSumSubPresence == true);

  // var check = toBeChecked(regexHasAnyOperation, results);

  // if (check == false) {
  //   return print(results);
  // } else {
  //   return calculator(results);
  // }
}

bool toBeChecked(RegExp toBeCheckedRegex, String results) {
  bool hasChecked = toBeCheckedRegex.hasMatch(results);
  return hasChecked;
}

// calculator(operation) {
//   var results = operation;

//   var checkPercentSingle = checkOperation(regexPercentSingle, results);
//   if (checkPercentSingle) {
//     String match = '';
//     RegExp exp = RegExp(r"(^([0-9.]+)\%)");

//     String currentOperaton = results;

//     Iterable<Match> matches = exp.allMatches(currentOperaton);
//     for (var m in matches) {
//       match = m[0]!;
//     }

//     var numbers = match.split(RegExp(r"[\%]"));

//     var result;
//     var n = double.tryParse(numbers[0]);
//     if (n != null) {
//       result = n / 100;
//     }

//     results = results.replaceAll(RegExp(r"(^([0-9.]+)\%)"), result.toString());

//     print(result);
//   }

//   var checkDivOperation = checkOperation(regexDivOperation, results);
//   if (checkDivOperation) {
//     results = singleOperation(results, regexDivOperation, regexDivOperator,
//         regexDivPercentOperators, div);
//   }

//   var checkMultOperation = checkOperation(regexMultOperation, results);
//   if (checkMultOperation) {
//     results = singleOperation(results, regexMultOperation, regexMultOperator,
//         regexMultPercentOperators, mult);
//   }

//   var checkSumOperation = checkOperation(regexSumOperation, results);
//   if (checkSumOperation) {
//     results = singleOperation(results, regexSumOperation, regexSumOperator,
//         regexSumPercentOperators, sum);
//   }

//   var checkMinusOperation = checkOperation(regexMinusOperation, results);
//   if (checkMinusOperation) {
//     results = singleOperation(results, regexMinusOperation, regexMinusOperator,
//         regexMultPercentOperators, sub);
//   }

//   var check = checkOperation(regexHasAnyOperation, results);

//   if (check == false) {
//     return print(results);
//   } else {
//     return calculator(results);
//   }
// }

sum(a, b) {
  return a + b;
}

sub(a, b) {
  return a - b;
}

mult(a, b) {
  return a * b;
}

div(a, b) {
  return a / b;
}

percent(a, b) {
  return (b / 100) * a;
}
