class LabData {
  final List<String> ID;
  final List<String> Question;
  LabData({
    required this.ID,
    required this.Question,
  });
}

LabData TestData = LabData(ID: <String>[
  "N170694",
  "N170713",
  "N170683",
  "N170470",
  "N170555",
  "N170938"
], Question: <String>[
  "Write a program to print prime numbers",
  "Write a program to print palindromes",
  "Write a program to print a triangle",
  "Write a program for matrix multiplication",
  "Write a program for strinf reversal"
]);
