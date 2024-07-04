import 'dart:convert';
import 'dart:io';

const String pathToFile = '/path/to/your/file.txt';

void main() async {
  final file = File(pathToFile);

  List<int> numbers = [];
  int? maxNumber;
  int? minNumber;
  double median;
  double average;
  int sum = 0;
  int count = 0;

  List<int> longestIncreasingSequence = [];
  List<int> currentIncreasingSequence = [];
  List<int> longestDecreasingSequence = [];
  List<int> currentDecreasingSequence = [];

  await for (String line in file.openRead().transform(utf8.decoder).transform(LineSplitter())) {
    int number = int.parse(line);
    numbers.add(number);

    if (maxNumber == null || number > maxNumber) {
      maxNumber = number;
    }
    if (minNumber == null || number < minNumber) {
      minNumber = number;
    }

    sum += number;
    count++;

    if (currentIncreasingSequence.isEmpty || number > currentIncreasingSequence.last) {
      currentIncreasingSequence.add(number);
    } else {
      if (currentIncreasingSequence.length > longestIncreasingSequence.length) {
        longestIncreasingSequence = currentIncreasingSequence;
      }
      currentIncreasingSequence = [number];
    }

    if (currentDecreasingSequence.isEmpty || number < currentDecreasingSequence.last) {
      currentDecreasingSequence.add(number);
    } else {
      if (currentDecreasingSequence.length > longestDecreasingSequence.length) {
        longestDecreasingSequence = currentDecreasingSequence;
      }
      currentDecreasingSequence = [number];
    }
  }

  if (currentIncreasingSequence.length > longestIncreasingSequence.length) {
    longestIncreasingSequence = currentIncreasingSequence;
  }
  if (currentDecreasingSequence.length > longestDecreasingSequence.length) {
    longestDecreasingSequence = currentDecreasingSequence;
  }

  average = sum / count;

  numbers.sort();
  int middle = numbers.length ~/ 2;
  if (numbers.length % 2 == 1) {
    median = numbers[middle].toDouble();
  } else {
    median = (numbers[middle - 1] + numbers[middle]) / 2;
  }

  print('Максимальне число: $maxNumber');
  print('Мінімальне число: $minNumber');
  print('Медіана: $median');
  print('Середнє арифметичне: $average');
  print('Найбільша збільшувальна послідовність: $longestIncreasingSequence');
  print('Найбільша зменшувальна послідовність: $longestDecreasingSequence');
}
