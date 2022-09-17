import 'package:flutter/material.dart';
import 'package:my_work/models/datamodel.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _currentPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carousel Widget"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(40.0),
            child: Text(
              "My Images",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          ),
          PageView.builder(
              itemCount: dataList.length,
              controller: _pageController,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return carouselView(index);
              })
        ],
      ),
    );
  }

  Widget carouselView(int index) {
    return Container();
  }

  Widget carouselCard(DataModel data) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(image: AssetImage(data.imageName!))),
        ),
      ],
    );
  }
}
