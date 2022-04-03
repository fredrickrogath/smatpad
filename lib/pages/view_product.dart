import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:smatpad/components/image_viewer.dart';

class viewProduct extends StatelessWidget {
  final image;
  const viewProduct({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            margin: const EdgeInsets.only(top: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          OpenContainer(
                            closedColor: Colors.white,
                            openColor: const Color(0xFF337A6F),
                            closedElevation: 0.0,
                            openElevation: 0.0,
                            closedShape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            transitionType: ContainerTransitionType.fade,
                            transitionDuration:
                                const Duration(milliseconds: 100),
                            openBuilder: (context, action) {
                              return imageViewer(image: image);
                            },
                            closedBuilder: (context, action) {
                              return AspectRatio(
                                aspectRatio: 4 / 3,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(20), // Image border
                                  child: SizedBox.fromSize(
                                      size: const Size.fromRadius(
                                          48), // Image radius
                                      child: Image(
                                        image: AssetImage('$image'),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                elevation: 0.0,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xFF337A6F),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Cocacola zero',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('75 orders',
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'Tsh 34000 ',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('/caton')
                              ],
                            ),
                            FloatingActionButton.extended(
                              onPressed: () {
                                // Add your onPressed code here
                              },
                              elevation: 0.0,
                              label: const Text(
                                'Add',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF337A6F),
                                ),
                              ),
                              icon: const Icon(
                                Icons.add,
                                color: Color(0xFF337A6F),
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                              height: 100.0,
                              width: MediaQuery.of(context).size.width,
                              color: const Color(0xffF1F9F7),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 8.0),
                                child: Text(
                                  "About product :  blabla bla bla njokosi",
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50.0,
                              color: const Color(0xffF1F9F7),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 8.0),
                                child: Text(
                                  "Delivery :  ",
                                  // style: TextStyle(color: Colors.red),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
