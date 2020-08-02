import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttercarrental/model/item.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttercarrental/second_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Find your flat",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black54,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.filter_list,
                color: Colors.black54,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 10.0,
                ),
                child: Text(
                  "${ApartmentModel.list.length} Results in your area",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondScreen(index)));
                      },
                      child: ItemList(index)),
                  itemCount: ApartmentModel.list.length,
                ),
              )
            ],
          ),
        ));
  }
}

class ItemList extends StatelessWidget {
  final int index;

  ItemList(this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        alignment: Alignment.centerLeft,
        overflow: Overflow.visible,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: ColorFiltered(
                colorFilter:
                    ColorFilter.mode(Colors.black54, BlendMode.overlay),
                child: Image.asset(
                  'images/1.${index + 1}.jpg',
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2.3,
            height: MediaQuery.of(context).size.width / 2.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "\$${ApartmentModel.list[index].price}/month",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      ApartmentModel.list[index].sizeDesc,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          RatingBar(
                            onRatingUpdate: (value) {},
                            initialRating: ApartmentModel.list[index].review,
                            itemSize: 12.0,
                            itemBuilder: (_, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "${ApartmentModel.list[index].reviewCount} reviews",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        ...ApartmentModel.list[index].personImages.map(
                          (personImage) => Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: ClipOval(
                              child: Image.asset(
                                'images/$personImage.jpg',
                                width: 25.0,
                                height: 25.0,
                              ),
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Container(
                            alignment: Alignment.center,
                            width: 25.0,
                            height: 25.0,
                            color: Colors.black12,
                            child: Text(
                              "23+",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Wrap(
                        children: [
                          ...ApartmentModel.list[index].features.map(
                            (feature) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Chip(
                                label: Text(
                                  feature,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                  ),
                                ),
                                backgroundColor: Colors.blue,
                                elevation: 6.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.width / 2.6,
            left: MediaQuery.of(context).size.width / 2.3,
            right: MediaQuery.of(context).size.width * 0.03,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ApartmentModel.list[index].name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Icon(
                    Icons.directions,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
