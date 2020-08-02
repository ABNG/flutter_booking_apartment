import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttercarrental/model/item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';

class SecondScreen extends StatefulWidget {
  final int index;

  SecondScreen(this.index);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _current_page = 0;
  final controller = PageController(
    initialPage: 0,
  );
  int current_index;
  int maxLines = 3;
  var width = 0.0;
  var value = 0.0;
  var booked = false;
  var maxwidth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    current_index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    maxwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (v) {
                setState(() {
                  _current_page = v;
                });
              },
              itemCount: ApartmentModel.list.length,
              itemBuilder: (context, index) => Image.asset(
                'images/${ApartmentModel.list[current_index].images[index]}.jpg',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "\$${ApartmentModel.list[current_index].price}/",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        "months",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: MediaQuery.of(context).size.width / 2.5,
            child: SliderIndicator(
              activeIndex: _current_page,
              activeIndicator: Icon(
                Icons.radio_button_checked,
                color: Colors.white,
                size: 20.0,
              ),
              length: ApartmentModel.list.length,
              indicator: Icon(
                Icons.radio_button_unchecked,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 0.8,
            builder: (context, scroll) {
              return SingleChildScrollView(
                controller: scroll,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 25.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(30.0),
                          right: Radius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              child: Icon(
                                Icons.drag_handle,
                                color: Colors.black54,
                              ),
                              alignment: Alignment.topCenter,
                            ),
                            Text(
                              ApartmentModel.list[current_index].name,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: MyCard(
                                    title: "Living Room",
                                    detail:
                                        "${ApartmentModel.list[current_index].sizeLivingRoom} sqft",
                                  ),
                                ),
                                Expanded(
                                  child: MyCard(
                                    title: "Bed Room",
                                    detail:
                                        "${ApartmentModel.list[current_index].sizeBedRoom} sqft",
                                  ),
                                ),
                                Expanded(
                                  child: MyCard(
                                    title: "Bath Room",
                                    detail:
                                        "${ApartmentModel.list[current_index].sizeBathRoom} sqft",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              ApartmentModel.list[current_index].desc,
                              maxLines: maxLines,
                              overflow: TextOverflow.ellipsis,
                            ),
                            RichText(
                              text: TextSpan(
                                  text:
                                      maxLines == 3 ? "Read more" : "Read less",
                                  style: TextStyle(
                                    color: Colors.green.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        if (maxLines == 3) {
                                          maxLines = 10;
                                        } else {
                                          maxLines = 3;
                                        }
                                      });
                                    }),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: MediaQuery.of(context).size.width * 0.06,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.15,
          right: MediaQuery.of(context).size.width * 0.15,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: booked ? Colors.greenAccent : Colors.indigo,
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: booked ? Colors.greenAccent : Colors.indigo,
              width: 3,
            ),
          ),
          height: 60.0,
          child: Stack(
            children: [
              Center(
                child: Shimmer(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black87,
                      Colors.white60,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  child: Text(
                    booked ? "Booked" : "Slide to Book",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 100),
                width: width <= 55 ? 55 : width,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(),
                    ),
                    GestureDetector(
                      onVerticalDragUpdate: onDrag,
                      onVerticalDragEnd: onDragEnd,
                      child: Container(
                        width: 55.0,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Icon(Icons.keyboard_arrow_right),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onDrag(DragUpdateDetails details) {
    setState(() {
      value = (details.globalPosition.dx) / maxwidth;
      width = maxwidth * value;
    });
  }

  void onDragEnd(DragEndDetails details) {
    if (value > 0.9) {
      value = 1;
    } else {
      value = 0;
    }
    setState(() {
      width = maxwidth * value;
      booked = value > 0.9;
    });
  }
}

class MyCard extends StatelessWidget {
  final String title;
  final String detail;

  MyCard({this.title, this.detail});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            Text(
              detail,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
      shadowColor: Colors.black54,
      elevation: 5.0,
    );
  }
}
