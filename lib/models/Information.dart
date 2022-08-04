class Information {
  final List<String> Departments;
  final List<String> Subjects;
  final List<String> Sections;
  final List<String> Periods;
  final List<String> AcYear;
  final List<String> Semester;
  Information({
    required this.Departments,
    required this.Subjects,
    required this.Sections,
    required this.Periods,
    required this.AcYear,
    required this.Semester,
  });
}

Information sampleData = Information(
  Departments: <String>["CSE", "ECE", "MECH", "CIVIL", "MME", "CHEM", "EEE"],
  Subjects: <String>[
    "DIP",
    "DIP_LAB",
    "Data Science",
    "CNS",
    "ST",
    "MATRIX ALGEBRA"
  ],
  Sections: <String>[
    "Cse-01",
    "Cse-02",
    "Cse-03",
    "Cse-04",
    "Cse-05",
    "Cse-06",
    "Cse-07",
    "Cse-08",
  ],
  Periods: [
    "P1",
    "P2",
    "P3",
    "P4",
    "P5",
    "P6",
    "P7",
  ],
  AcYear: ["2020-21", "2021-22", "2022-23"],
  Semester: ["Sem-1", "Sem-2"],
);
