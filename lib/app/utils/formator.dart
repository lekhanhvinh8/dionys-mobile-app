class Formator {
  static String formatMoney(double amountOfMoney) {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

    //var amountOfMoneyInString = amountOfMoney.toString().replaceAll(regex, '');
    var amountOfMoneyInString = amountOfMoney.toString();

    if (amountOfMoneyInString.length <= 3) return amountOfMoneyInString;

    var formated = [];

    var pointIndex = 0;

    for (var i = amountOfMoneyInString.length - 1; i >= 0; i--) {
      formated.add(amountOfMoneyInString[i]);
      pointIndex += 1;

      if (pointIndex == 3) {
        formated.add(".");
        pointIndex = 0;
      }
    }

    if (formated[formated.length - 1] == ".") formated.removeLast();

    return formated.reversed.toList().join("");
  }
}
