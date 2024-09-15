import 'dart:io';

import 'utils.dart';

// declare
int jumVar = 0;
List<List<double>> arrMatrix = [[]];
int tempOutput = 0;

// logging
late bool isLog;

void main(List<String> args) {
  // init logging
  isLog = (args.isNotEmpty && args[0] == "-log");

  // meminta input berapa variabel? (minimal 2 variabel, maks terserah)
  stdout.write("Enter how many variables you want to calculate?\n=> ");
  jumVar = inputValidation(stdin.readLineSync()).round();

  // Meminta input persamaan dari user
  // rencananya akan saya buat A, B, C, ... dst
  // declare array
  arrMatrix = new List.generate(
      jumVar, (indexBaris) => new List.generate(jumVar + 1, (indexKolom) => 0));

  // meminta input isi persamaan
  askInput();

  // Pembatas
  stdout.write(
      "\n\n================== PROCESSS - Making a 0 under the diagonal ==================\n\n");

  // Show matrix
  showMatrix(arrMatrix);

  // Proses Membuat 0 (Gauss Gauss)
  process0();

  // Pembatas
  stdout.write(
      "\n\n================== PROCESSS - Making the number 1 on the diagonal ==================\n\n");

  // Show matrix
  showMatrix(arrMatrix);

  // Proses Membuat 1 (Gauss Jordan)
  process1();

  // Pembatas
  stdout.write(
      "\n\n================== PROCESSS - Making a 0 above the diagonal ==================\n\n");

  // Show matrix
  showMatrix(arrMatrix);

  // Proses Membuat 0 (Gauss Jordan)
  process0v2();

  // Output Result
  print("\n\nVariable results found!\n");
  for (var row = 0; row < arrMatrix.length; row++) {
    try {
      tempOutput = arrMatrix[row].last.round();
    } catch (_) {
      tempOutput = 0;
    }
    print("x${row + 1} (variable ${row + 1}) = ${tempOutput}");
  }
}

double inputValidation(String? input) {
  while (input == null || input.isEmpty || int.tryParse(input) == null) {
    if (input == null || input.isEmpty) {
      print("\nYou must provide an input!");
      stdout.write("Enter how many variables you want to calculate?\n=> ");
      input = stdin.readLineSync();
    } else {
      print("\nThe input must be a number!");
      stdout.write("Enter how many variables you want to calculate?\n=> ");
      input = stdin.readLineSync();
    }
  }
  return double.parse(input);
}

void showMatrix(List<List<double>> arr) {
  print("The resulting Matrix:");
  int i = 1;
  arr.forEach((array1dim) {
    stdout.write("B$i | ");
    for (var col = 0; col < array1dim.length - 1; col++) {
      stdout.write("${array1dim[col].toStringAsPrecision(3)} ");
    }
    print("= ${array1dim[array1dim.length - 1].toStringAsPrecision(3)}");
    i++;
  });
}

void askInput() {
  for (var baris = 0; baris < jumVar; baris++) {
    for (var kolom = 0; kolom < jumVar; kolom++) {
      // print("\n$arrMatrix");
      showMatrix(arrMatrix);
      stdout.write("\nEnter B${baris + 1} variable ${kolom + 1}\n=> ");
      arrMatrix[baris][kolom] = inputValidation(stdin.readLineSync());
    }
    // print("\n$arrMatrix");
    showMatrix(arrMatrix);
    stdout.write("\nEnter the equation result from B${baris + 1} \n=> ");
    arrMatrix[baris][jumVar] = inputValidation(stdin.readLineSync());
  }
}

void process0() {
  for (var i = 0; i < jumVar - 1; i++) {
    print("\n");
    // arrMatrixBaru = arrMatrix;
    for (var row = i + 1; row < arrMatrix.length; row++) {
      int col = i;
      double kunciTop = arrMatrix[row][col];
      double kunciBottom = arrMatrix[col][col];

      // mengadaptasi satu deretan di row tersebut
      Utils.getLogging(
        isLog: isLog,
        message: "===== CALCULATION START (on the B${row + 1})",
      );
      var res = List.generate(arrMatrix[row].length, (index) {
        Utils.getLogging(
          isLog: isLog,
          message:
              "${arrMatrix[row][index]} - $kunciTop/$kunciBottom x ${arrMatrix[col][index]} is ${arrMatrix[row][index] - kunciTop / kunciBottom * arrMatrix[col][index]}",
        );
        return arrMatrix[row][index] -
            kunciTop / kunciBottom * arrMatrix[col][index];
      });
      Utils.getLogging(
        isLog: isLog,
        message: "----- CALCULATION COMPLETED",
      );
      arrMatrix[row] = res;
    }
    showMatrix(arrMatrix);
  }
}

void process1() {
  for (var row = 0; row < arrMatrix.length; row++) {
    print("\n");
    List<double> tempValue =
        List<double>.generate(arrMatrix[row].length, (_) => 0);

    Utils.getLogging(
      isLog: isLog,
      message: "===== CALCULATION START (on the B${row + 1})",
    );
    for (var col = 0; col < arrMatrix[row].length; col++) {
      Utils.getLogging(
        isLog: isLog,
        message:
            "${arrMatrix[row][col]} / ${arrMatrix[row][row]} is ${arrMatrix[row][col] / arrMatrix[row][row]}",
      );
      tempValue[col] = arrMatrix[row][col] / arrMatrix[row][row];
    }
    Utils.getLogging(
      isLog: isLog,
      message: "----- CALCULATION COMPLETED",
    );

    arrMatrix[row] = List.from(tempValue);
    showMatrix(arrMatrix);
  }
}

void process0v2() {
  // Percobaan 2 (done)
  for (var i = jumVar - 1; i > 0; i--) {
    print("\n");
    // arrMatrixBaru = arrMatrix;

    for (var row = i - 1; row >= 0; row--) {
      int col = i;
      double kunciTop = arrMatrix[row][col];
      double kunciBottom = arrMatrix[col][col];

      Utils.getLogging(
        isLog: isLog,
        message: "===== CALCULATION START (on the B${row + 1})",
      );
      // mengadaptasi satu deretan di row tersebut
      var res = List.generate(arrMatrix[row].length, (index) {
        Utils.getLogging(
          isLog: isLog,
          message:
              "${arrMatrix[row][index]} - $kunciTop/$kunciBottom x ${arrMatrix[col][index]} is ${arrMatrix[row][index] - kunciTop / kunciBottom * arrMatrix[col][index]}",
        );
        return arrMatrix[row][index] -
            kunciTop / kunciBottom * arrMatrix[col][index];
      });
      Utils.getLogging(
        isLog: isLog,
        message: "----- CALCULATION COMPLETED",
      );
      arrMatrix[row] = res;
    }

    showMatrix(arrMatrix);
  }
}
