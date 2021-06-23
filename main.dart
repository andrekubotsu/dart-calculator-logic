import 'dart:io';

void main() {
  var teste = stdin.readLineSync();

  calculator(teste);

  // var calc = -100 - 10;
  // print(calc);
}

RegExp regexDivExpression = RegExp(r"(^([\-0-9.]+)\/([0-9.]+))");
RegExp regexMultExpression = RegExp(r"(^([\-0-9.]+)\*([0-9.]+))");
RegExp regexSumExpression = RegExp(r"(^([\-0-9.]+)\+([0-9.]+))");
RegExp regexMinusExpression = RegExp(r"(^([\-0-9.]+)\-([0-9.]+))");

RegExp regexDivOperator = RegExp(r"[\/]");
RegExp regexMultOperator = RegExp(r"[\*]");
RegExp regexSumOperator = RegExp(r"[\+]");
RegExp regexMinusOperator = RegExp(r"[\-]");

singleOperation(
  //operationString,
  results,
  expressionRegex,
  operatorRegex,
  operationFunction,
) {
  String match = '';

  String currentOperaton = results;
  Iterable<Match> matches = expressionRegex.allMatches(currentOperaton);
  for (var m in matches) {
    match = m[0]!;
  }

  var numbers = match.split(operatorRegex);

  var a = double.tryParse(numbers[0]);
  var b = double.tryParse(numbers[1]);

  var result = operationFunction(a, b);

  results = results.replaceAll(expressionRegex, result.toString());

  print(results);

  return results;
}

calculator(operation) {
  var results = operation;

  if (results.indexOf('%') > -1) {
    String match = '';
    RegExp exp = RegExp(r"(^([0-9.]+)\%)");

    String currentOperaton = results;

    Iterable<Match> matches = exp.allMatches(currentOperaton);
    for (var m in matches) {
      match = m[0]!;
    }

    if (match == '') {
      results = operation;
    } else {
      var numbers = match.split(RegExp(r"[\%]"));

      var result;
      var n = double.tryParse(numbers[0]);
      if (n != null) {
        result = n / 100;
      }

      results =
          results.replaceAll(RegExp(r"(^([0-9.]+)\%)"), result.toString());

      print(result);
    }
  }

  if (results.indexOf('/') > -1) {
    results =
        singleOperation(results, regexDivExpression, regexDivOperator, div);
  }

  if (results.indexOf('*') > -1) {
    results =
        singleOperation(results, regexMultExpression, regexMultOperator, mult);
  }

  if (results.indexOf('+') > -1) {
    results =
        singleOperation(results, regexSumExpression, regexSumOperator, sum);
  }

  if (results.indexOf('-') > -1) {
    results =
        singleOperation(results, regexMinusExpression, regexMinusOperator, sub);
    // String match = '';
    // RegExp expMinus = RegExp(r"(([0-9.]+)\-([0-9.]+))");
    // RegExp expMinusPercent = RegExp(r"^(([0-9.]+)\-([0-9.]+)\%)");
    // String currentOperaton = results;

    // var matchesPercent = expMinusPercent.firstMatch(currentOperaton);

    // if (matchesPercent == null) {
    //   Iterable<Match> matches = expMinus.allMatches(currentOperaton);
    //   for (var m in matches) {
    //     match = m[0]!;
    //   }

    //   var numbers = match.split(RegExp(r"[\-]"));

    //   var a = double.tryParse(numbers[0]);
    //   var b = double.tryParse(numbers[1]);

    //   var result = sub(a, b);

    //   results = results.replaceAll(
    //       RegExp(r"(([0-9.]+)\-([0-9.]+))"), result.toString());

    //   print(results);
    // } else {
    //   var numbers = matchesPercent[0].toString().split(RegExp(r"[\-\%]"));

    //   var a = double.tryParse(numbers[0]);
    //   var b = double.tryParse(numbers[1]);

    //   var percentValue = percent(a, b);

    //   var result = sub(a, percentValue);

    //   results = results.replaceAll(
    //       RegExp(r"^(([0-9.]+)\-([0-9.]+)\%)"), result.toString());

    //   print(results);
    // }
  }

  //TODO: tratamento de erro e vazio, implementação da recursão

  return print(results); //calculator(results);
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
