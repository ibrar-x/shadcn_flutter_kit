part of 'formatter.dart';

class _MathExpressionFormatter extends TextInputFormatter {
  final Map<String, dynamic>? context;
  const _MathExpressionFormatter({this.context});
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;
    Object? result;
    try {
      Expression expression = Expression.parse(newText);
      ExpressionEvaluator evaluator = const ExpressionEvaluator();
      result = evaluator.eval(expression, context ?? {});
      if (result is! num) {
        result = '';
      }
    } catch (e) {
      result = '';
    }
    String resultText = result.toString();
    if (resultText.contains('.')) {
      while (resultText.endsWith('0')) {
        resultText = resultText.substring(0, resultText.length - 1);
      }
      if (resultText.endsWith('.')) {
        resultText = resultText.substring(0, resultText.length - 1);
      }
    }
    return TextEditingValue(
      text: resultText,
      selection: contraintToNewText(newValue, resultText),
    );
  }
}
