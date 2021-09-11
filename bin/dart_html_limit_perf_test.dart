import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

class BenchHtml extends BenchmarkBase {
  BenchHtml(this.document) : super('BenchHtml');

  final Document document;

  @override
  void run() {
    // final elements = document.querySelectorAll('.mw-headline');
    final elements = document.querySelectorAll('.mw-headline', limit: 4);

    print(elements.map((e) => e.text).toList());
  }
}

void main() async {
  var url = Uri.parse('https://en.wikipedia.org/wiki/Earth');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final document = parse(response.body);
    BenchHtml(document).report();
  } else {
    throw ('Invalid response status');
  }
}

