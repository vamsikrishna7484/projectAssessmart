class DataModel {
  final String? title;
  final String? imageName;
  DataModel(
    this.title,
    this.imageName,
  );
}

List<DataModel> dataList = [
  DataModel("Barbie Frock", "assets/Brabie_frock.jpg"),
  DataModel("Long Frock", "assets/long_frock.jpg"),
  DataModel("Short Frock", "assets/short_frock.jpg")
];
