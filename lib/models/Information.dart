class Information {
  final List<String> Departments;
  final List<String> Subjects;
  final List<String> Sections;
  final List<String> Periods;
  final List<String> AcYear;
  final List<String> Semester;
  final List<String> Year;
  Information({
    required this.Departments,
    required this.Subjects,
    required this.Sections,
    required this.Periods,
    required this.AcYear,
    required this.Semester,
    required this.Year,
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
    "Section 1",
    "Section 2",
    "Section 3",
    "Section 4",
    "Section 5",
    "Section 6",
    "Section 7",
    "Section 8",
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
  Year: ['PUC1', 'PUC2', 'E1', 'E2', 'E3', 'E4'],
);
