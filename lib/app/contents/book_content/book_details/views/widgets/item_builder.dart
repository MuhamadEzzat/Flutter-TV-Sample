import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../controller/book_detials_controller.dart';

class BookItemBuilder extends GetView<BookDetailsController> {
  final int? value;

  const BookItemBuilder({Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: Get.width,
          height: Get.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
              ),
            ],
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                controller.book.bookPages[value ?? 0].image,
                cacheManager: DefaultCacheManager(),
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: 30.h,
          right: 10.w,
          child: Container(
            width: 160.w,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
              child: StreamBuilder<int>(
                stream: controller.highlightedIndex!.stream,
                builder: (context, snapshot) {
                  return RichText(
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    text: TextSpan(
                      children: [
                        for (int i = 0;
                            i <
                                controller.book.bookPages[value ?? 0].text
                                    .split(" ")
                                    .length;
                            i++)
                          TextSpan(
                            text:
                                "${controller.book.bookPages[value ?? 0].text.split(" ")[i]} ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: snapshot.data != null &&
                                        i ==
                                            (snapshot.data! -
                                                controller
                                                    .totalMarkedPagesMarkerLength
                                                    .value)
                                    ? const Color(0xff00B848)
                                    : Colors.black),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
