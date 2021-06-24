import 'dart:io';

void main() {
  var teste = stdin.readLineSync();

  calculator(teste);

  // var calc = -100 - 10;
  // print(calc);
}

RegExp regexDivOperation = RegExp(r"(^([\-0-9.]+)\/([0-9.]+))");
RegExp regexMultOperation = RegExp(r"(^([\-0-9.]+)\*([0-9.]+))");
RegExp regexSumOperation = RegExp(r"(^([\-0-9.]+)\+([0-9.]+))");
RegExp regexMinusOperation = RegExp(r"(^([\-0-9.]+)\-([0-9.]+))");
RegExp regexPercentSingle = RegExp(r"(^([0-9.]+)\%)");

RegExp regexHasAnyOperation = RegExp(r"(^([\-0-9.]+)[\-\+\*\/]([0-9.]+))");

RegExp regexDivOperator = RegExp(r"[\/]");
RegExp regexMultOperator = RegExp(r"[\*]");
RegExp regexSumOperator = RegExp(r"[\+]");
RegExp regexMinusOperator = RegExp(r"\-(?!.*\-)");
RegExp regexPecent = RegExp(r"[\%]");

//TODO: operações com porcentagem

singleOperation(
  results,
  operationRegex,
  operatorRegex,
  operationFunction,
) {
  String match = '';

  String currentOperaton = results;
  Iterable<Match> matches = operationRegex.allMatches(currentOperaton);
  for (var m in matches) {
    match = m[0]!;
  }

  var numbers = match.split(operatorRegex);

  var a = double.tryParse(numbers[0]);
  var b = double.tryParse(numbers[1]);

  var result = operationFunction(a, b);

  results = results.replaceAll(operationRegex, result.toString());

  print(results);

  return results;
}

checkOperation(OperationRegex, results) {
  var hasOperation = OperationRegex.hasMatch(results);
  return hasOperation;
}

calculator(operation) {
  var results = operation;

  var checkPercentSingle = checkOperation(regexPercentSingle, results);
  if (checkPercentSingle) {
    String match = '';
    RegExp exp = RegExp(r"(^([0-9.]+)\%)");

    String currentOperaton = results;

    Iterable<Match> matches = exp.allMatches(currentOperaton);
    for (var m in matches) {
      match = m[0]!;
    }

    var numbers = match.split(RegExp(r"[\%]"));

    var result;
    var n = double.tryParse(numbers[0]);
    if (n != null) {
      result = n / 100;
    }

    results = results.replaceAll(RegExp(r"(^([0-9.]+)\%)"), result.toString());

    print(result);
  }

  var checkDivOperation = checkOperation(regexDivOperation, results);
  if (checkDivOperation) {
    results =
        singleOperation(results, regexDivOperation, regexDivOperator, div);
  }

  var checkMultOperation = checkOperation(regexMultOperation, results);
  if (checkMultOperation) {
    results =
        singleOperation(results, regexMultOperation, regexMultOperator, mult);
  }

  var checkSumOperation = checkOperation(regexSumOperation, results);
  if (checkSumOperation) {
    results =
        singleOperation(results, regexSumOperation, regexSumOperator, sum);
  }

  var checkMinusOperation = checkOperation(regexMinusOperation, results);
  if (checkMinusOperation) {
    results =
        singleOperation(results, regexMinusOperation, regexMinusOperator, sub);
  }

  var check = checkOperation(regexHasAnyOperation, results);

  if (check == false) {
    return print(results);
  } else {
    return calculator(results);
  }
}

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
