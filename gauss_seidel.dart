import 'dart:io';

// declare
int jumVar = 0;
List<List<double>> arrMatrix = [[]];
List<double> gaussSeidleResult = [];

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

  // Validasi persyaratan gauss seidel
  // variabel diagnal harus lebih besar dari yang lain
  if (!gaussIsValid()) {
    print("\nMaaf persamaan ini tidak bisa menggunakan rumus gauss seidel");
    return;
  }
  print("\nPersamaan dapat menggunakan Gauss Seidel!\n");

  // Proses
  gaussSeidleResult = processGaus();

  // Reuslt print
  print("Hasil dari variabel adalah:");
  gaussSeidleResult.forEach((element) {
    print(element);
  });
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

bool gaussIsValid() {
  for (var row = 0; row < jumVar; row++) {
    for (var col = 0; col < jumVar; col++) {
      if (col == 0) {
        if (arrMatrix[row][row] < arrMatrix[row][col]) {
          return false;
        }
      } else if (col == jumVar - 1) {
        if (arrMatrix[row][col] > arrMatrix[row][row]) {
          return false;
        }
      } else {
        if (arrMatrix[row][col] > arrMatrix[row][row] ||
            arrMatrix[row][row] < arrMatrix[row][col]) {
          return false;
        }
      }
    }
  }
  return true;
}

List<double> processGaus() {
  bool isLoop = true;

  // declare var
  List<double> valueLama = [];
  List<double> valueBaru = List.generate(jumVar, (_) => 0);

  while (isLoop) {
    valueLama = List.from(valueBaru);

    for (var row = 0; row < jumVar; row++) {
      double resVal = arrMatrix[row][jumVar];

      for (var col = 0; col < jumVar; col++) {
        if (row != col) resVal -= arrMatrix[row][col] * valueLama[col];
      }
      valueBaru[row] = resVal / arrMatrix[row][row];
    }

    print("LIST 1 = ${valueLama}");
    print("LIST 2 = ${valueBaru}");

    // check apakah value lama == value baru
    if (valueLama.every((element) => valueBaru.contains(element))) {
      isLoop = false;
    }
  }

  return valueBaru;
}
