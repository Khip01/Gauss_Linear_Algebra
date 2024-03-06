import 'dart:io';

// declare
// int jumVar;
int jumVar = 0;
String? inputvalidation;
List<List<double>> arrMatrix = [[]];
// List<List<double>> arrMatrixBaru = [[]];
// List<List<double>> arrMatrixBaruBaru = [[]];

void main() {
  // meminta input berapa variabel? (minimal 2 variabel, maks terserah)
  stdout.write("Masukkan berapa variabel yang ingin dihitung?\n=> ");
  jumVar = inputValidation(stdin.readLineSync()).round();

  // Meminta input persamaan dari user
  // rencananya akan saya buat A, B, C, ... dst
  // declare array
  arrMatrix = new List.generate(
      jumVar, (indexBaris) => new List.generate(jumVar + 1, (indexKolom) => 0));

  // meminta input isi persamaan
  askInput();

  // Pembatas
  stdout.write("\n\n==================PROCESSS==================");

  // Show matrix
  showMatrix(arrMatrix);

  // Proses Membuat 0
  process0();

  // Proses Hasil A B C
  processResult();
}

double inputValidation(String? input) {
  while (input == null || input.isEmpty || int.tryParse(input) == null) {
    if (input == null || input.isEmpty) {
      print("\nAnda harus memasukkan sebuah input!");
      stdout.write("Masukkan berapa variabel yang ingin dihitung?\n=> ");
      input = stdin.readLineSync();
    } else {
      print("\nInput harus angka!");
      stdout.write("Masukkan berapa variabel yang ingin dihitung?\n=> ");
      input = stdin.readLineSync();
    }
  }
  return double.parse(input);
}

void showMatrix(List<List<double>> arr) {
  print("\n\nMatrix yang terbentuk:");
  arr.forEach((array1dim) {
    for (var col = 0; col < array1dim.length - 1; col++) {
      stdout.write("${array1dim[col].toStringAsPrecision(3)} ");
    }
    print("= ${array1dim[array1dim.length - 1].toStringAsPrecision(3)}");
  });
}

void askInput() {
  for (var baris = 0; baris < jumVar; baris++) {
    for (var kolom = 0; kolom < jumVar; kolom++) {
      // print("\n$arrMatrix");
      showMatrix(arrMatrix);
      stdout.write("\nMasukkan B${baris + 1} variable ke-${kolom + 1}\n=> ");
      arrMatrix[baris][kolom] = inputValidation(stdin.readLineSync());
    }
    // print("\n$arrMatrix");
    showMatrix(arrMatrix);
    stdout.write("\nMasukkan hasil Persamaan dari B${baris + 1} \n=> ");
    arrMatrix[baris][jumVar] = inputValidation(stdin.readLineSync());
  }
}

// void processZero() {
//   arrMatrixBaru = arrMatrix;
//   for (var row = 1; row < arrMatrix.length; row++) {
//     int col = 0;
//     double kunciTop = arrMatrix[row][col];
//     double kunciBottom = arrMatrix[col][col];

//     // mengadaptasi satu deretan di row tersebut
//     var res = List.generate(arrMatrix[row].length, (index) {
//       return arrMatrix[row][index] -
//           kunciTop / kunciBottom * arrMatrix[col][index];
//     });
//     arrMatrixBaru[row] = res;
//   }
// }

// void processZero2() {
//   arrMatrixBaruBaru = arrMatrixBaru;
//   for (var row = 2; row < arrMatrixBaru.length; row++) {
//     int col = 1;
//     double kunciTop = arrMatrixBaru[row][col];
//     double kunciBottom = arrMatrixBaru[col][col];

//     // mengadaptasi satu deretan di row tersebut
//     var res = List.generate(arrMatrixBaru[row].length, (index) {
//       return arrMatrixBaru[row][index] -
//           kunciTop / kunciBottom * arrMatrixBaru[col][index];
//     });
//     arrMatrixBaruBaru[row] = res;
//   }
// }

void process0() {
  for (var i = 0; i < jumVar - 1; i++) {
    // arrMatrixBaru = arrMatrix;
    for (var row = i + 1; row < arrMatrix.length; row++) {
      int col = i;
      double kunciTop = arrMatrix[row][col];
      double kunciBottom = arrMatrix[col][col];

      // mengadaptasi satu deretan di row tersebut
      var res = List.generate(arrMatrix[row].length, (index) {
        return arrMatrix[row][index] -
            kunciTop / kunciBottom * arrMatrix[col][index];
      });
      arrMatrix[row] = res;
    }
    showMatrix(arrMatrix);
  }
}

void processResult() {
  List<int> result = List.generate(jumVar, (_) => 0);
  // A B C
  // 0 0 0
  // 0 1 2

  // for (var index = jumVar - 1; index >= 0; index--) {
  //   result[index] = ((arrMatrixBaru[index][jumVar] - // Persamaan
  //               (arrMatrixBaru[index][jumVar - 1] * result[2]) - // variabel C
  //               (arrMatrixBaru[index][jumVar - 2] * result[1])) / // variabel B
  //           arrMatrixBaru[index]
  //               [jumVar - (jumVar - index)] // variable itu sendiri
  //       )
  //       .round();
  //   // 15,666
  // }

  // // Rumus
  // // C = ((arrMatrixBaruBaru[2][jumVar] - (arrMatrixBaruBaru[2][jumVar - 1] * C) - (arrMatrixBaruBaru[2][jumVar - 2] * B)) / arrMatrixBaruBaru[2][jumVar - 1]).round(); // 2 1
  // // B = ((arrMatrixBaruBaru[1][jumVar] - (arrMatrixBaruBaru[1][jumVar - 1] * C) - (arrMatrixBaruBaru[1][jumVar - 2] * B)) / arrMatrixBaruBaru[1][jumVar - 2]).round(); // 1 2
  // // A = ((arrMatrixBaruBaru[0][jumVar] - (arrMatrixBaruBaru[0][jumVar - 1] * C) - (arrMatrixBaruBaru[0][jumVar - 2] * B)) / arrMatrixBaruBaru[0][jumVar - 3]).round(); // 0 3

  // print("\nResult HP dari $jumVar variabel adalah:\n${result}");

  for (int row = result.length - 1; row >= 0; row--) {
    double sumRes = 0, value = 0;
    for (int col = result.length - 1; col >= 0; col--) {
      if (row == col) {
        value += arrMatrix[row][col];
        continue;
      }
      sumRes += arrMatrix[row][col] * result[col];
    }
    try {
      result[row] = ((arrMatrix[row][jumVar] - sumRes) / value).round();
    } catch (_) {
      result[row] = 0;
    }
  }

  print("\nResult HP dari $jumVar variabel adalah:\n${result}");
}
