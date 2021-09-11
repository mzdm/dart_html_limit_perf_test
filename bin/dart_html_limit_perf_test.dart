import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

class BenchHtmlLimit extends BenchmarkBase {
  BenchHtmlLimit(this.document) : super('BenchHtmlLimit');

  final Document document;

  @override
  void run() {
    document.querySelectorAll('.mw-headline', limit: 4);
    // print(elements.map((e) => e.text).toList());
  }
}

class BenchHtml extends BenchmarkBase {
  BenchHtml(this.document) : super('BenchHtml');

  final Document document;

  @override
  void run() {
    document.querySelectorAll('.mw-headline').take(4).toList();
    // print(elements.map((e) => e.text).toList());
  }
}


void main() async {
  var url = Uri.parse('https://en.wikipedia.org/wiki/Earth');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final document = parse(response.body);
    final benchmarks = [BenchHtml(document), BenchHtmlLimit(document)];
    for (var benchmark in benchmarks) {
      benchmark.report();
    }
  } else {
    throw ('Invalid response status');
  }
}

