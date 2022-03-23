import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class imageViewer extends StatelessWidget {
  final image;
  const imageViewer({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(top: 25.0),
          child: Stack(
            children: [
              PhotoView(
                backgroundDecoration: const BoxDecoration(color: Colors.white),
                enableRotation: true,
                enablePanAlways: true,
                imageProvider: AssetImage('$image'),
              ),
              Positioned(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
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
        ),
      ),
    );
  }
}
