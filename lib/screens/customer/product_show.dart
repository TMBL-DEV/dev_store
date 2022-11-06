import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dev_store/models/product.dart';
import 'package:dev_store/services/firebase_storage_service.dart';
import 'package:dev_store/widgets/appbar.dart';
import 'package:dev_store/widgets/default_page_container.dart';
import 'package:dev_store/widgets/future_network_image.dart';
import 'package:flutter/material.dart';

class ProductShowPage extends StatefulWidget {
  const ProductShowPage({super.key});

  @override
  State<ProductShowPage> createState() => _ProductShowPageState();
}

class _ProductShowPageState extends State<ProductShowPage> {
  List<FutureBuilder> images = [];

  int photoIndex = 0;
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    if (arguments['product'] == null) {
      return const Text("something went wrong");
    }

    Product product = arguments['product'];

    for (var i = 0; i < product.imagePaths.length; i++) {
      if (!images.asMap().containsKey(i)) {
        var widget = networkImageWithPlaceHolder(
          promisedUrl: FirebaseStorageService.instance
              .getDownloadUrlFromPath(path: product.imagePaths[i]),
        );

        images.add(widget);
      }
    }

    return Scaffold(
      appBar: personalBar(title: 'DevStore 🔥'),
      body: defaultPageContainer(
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider.builder(
                itemCount: product.imagePaths.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        images[itemIndex],
                options: CarouselOptions(
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        photoIndex = index;
                      });
                    }),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: CarouselIndicator(
                count: product.imagePaths.length,
                index: photoIndex,
                activeColor: Colors.black,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Text(
                        "description",
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(product.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
