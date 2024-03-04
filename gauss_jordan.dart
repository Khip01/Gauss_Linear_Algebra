import 'dart:io';

int jumVar = 0;
List<List<double>> arrMatrix = [[]];
List<List<double>> arrMatrixBaru = [[]];

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
  stdout.write(
      "\n\n================== PROCESSS Membuat 0 bawah ==================");

  // Show matrix
  showMatrix(arrMatrix);

  // Proses Membuat 0 (Gauss Gauss)
  process0();

  // Pembatas
  stdout.write(
      "\n\n================== PROCESSS Membuat 1 diagonal ==================");

  // Proses Membuat 1 (Gauss Jordan)
  process1();

  // Pembatas
  stdout.write(
      "\n\n================== PROCESSS Membuat 0 atas ==================");

  // Proses Membuat 0 (Gauss Jordan)
  process0v2();

  // Output Result
  print("\n\nHasil variabel ditemukan!\n");
  for (var row = 0; row < arrMatrix.length; row++) {
    print("Variabel ke-${row + 1} = ${arrMatrix[row].last.round()}");
  }
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

void process1() {
  for (var row = 0; row < arrMatrix.length; row++) {
    List<double> tempValue =
        List<double>.generate(arrMatrix[row].length, (_) => 0);

    for (var col = 0; col < arrMatrix[row].length; col++) {
      tempValue[col] = arrMatrix[row][col] / arrMatrix[row][row];
    }

    arrMatrix[row] = List.from(tempValue);
    showMatrix(arrMatrix);
  }
}

void process0v2() {
  // Percobaan 2 (done)
  for (var i = jumVar - 1; i > 0; i--) {
    // arrMatrixBaru = arrMatrix;

    for (var row = i - 1; row >= 0; row--) {
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
