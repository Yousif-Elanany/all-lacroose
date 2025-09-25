// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:video_player/video_player.dart';
//
// class MediaListView extends StatefulWidget {
//   final List<String> mediaUrls;
//
//   const MediaListView({Key? key, required this.mediaUrls}) : super(key: key);
//
//   @override
//   _MediaListViewState createState() => _MediaListViewState();
// }
//
// class _MediaListViewState extends State<MediaListView> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200, // تعيين الارتفاع إلى 300 بكسل
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal, // جعل القائمة أفقية
//         itemCount: widget.mediaUrls.length,
//         itemBuilder: (context, index) {
//           String url = widget.mediaUrls[index];
//           url = url.replaceAll(r'\', '/'); // تصحيح مسار الرابط
//
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8), // إضافة مسافة بين العناصر
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10), // زوايا دائرية للعناصر
//               child: url.toLowerCase().endsWith('.mp4')
//                   ? VideoPlayerWidget(videoUrl: url)
//                   : CachedNetworkImage(
//                 imageUrl: url,
//                 width: 150, // عرض ثابت للصور
//                 height: 200,
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) => Center(child: CircularProgressIndicator()),
//                 errorWidget: (context, url, error) => Icon(Icons.error, size: 50),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;
//
//   const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);
//
//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool isPlaying = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         _controller.value.isInitialized
//             ? SizedBox(
//           width: 150, // عرض الفيديو ليكون مماثلًا للصور
//           height: 200,
//           child: VideoPlayer(_controller),
//         )
//             : Container(
//           width: 150,
//           height: 200,
//           color: Colors.grey.shade300,
//           child: Center(child: CircularProgressIndicator()),
//         ),
//         IconButton(
//           icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
//               color: Colors.white, size: 50),
//           onPressed: () {
//             setState(() {
//               isPlaying ? _controller.pause() : _controller.play();
//               isPlaying = !isPlaying;
//             });
//           },
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // مكتبة المؤشر

class MediaCarousel extends StatefulWidget {
  final List<String> mediaUrls;

  const MediaCarousel({Key? key, required this.mediaUrls}) : super(key: key);

  @override
  _MediaCarouselState createState() => _MediaCarouselState();
}

class _MediaCarouselState extends State<MediaCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 165, // ارتفاع الكاروسيل
              reverse: true,
              autoPlay: true, // تشغيل تلقائي
              autoPlayInterval: Duration(seconds: 5), // الانتقال كل 5 ثوانٍ
              enlargeCenterPage: false, // لا يوجد تأثير تكبير
              viewportFraction: 1.0, // يجعل العنصر يأخذ كامل العرض
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index; // تحديث المؤشر
                });
              },
            ),
            items: widget.mediaUrls.map((url) {
              String fixedUrl = url.replaceAll(r'\', '/'); // إصلاح مسار الرابط

              return ClipRRect(
                borderRadius: BorderRadius.circular(10), // زوايا مستديرة
                child: fixedUrl.toLowerCase().endsWith('.mp4')
                    ? VideoPlayerWidget(videoUrl: fixedUrl) // تشغيل الفيديو
                    : CachedNetworkImage(
                  imageUrl: fixedUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Colors.green.shade700,)),
                  errorWidget: (context, url, error) => Icon(Icons.error, size: 50),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 10), // مسافة بين الكاروسيل والمؤشر
          AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: widget.mediaUrls.length, // العدد الصحيح للعناصر
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Colors.green.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ ويدجت تشغيل الفيديو مع تحسينات
class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool isInitialized = false;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    String fixedUrl = widget.videoUrl.replaceAll(r'\', '/'); // تصحيح الرابط

    _controller = VideoPlayerController.network(fixedUrl)
      ..initialize().then((_) {
        setState(() {
          isInitialized = true;
        });
      }).catchError((error) {
        print("خطأ في تحميل الفيديو: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isInitialized
        ? GestureDetector(
      onTap: () {
        setState(() {
          if (isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
          isPlaying = !isPlaying;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          if (!isPlaying)
            Icon(
              Icons.play_circle_fill,
              color: Colors.white,
              size: 50,
            ),
        ],
      ),
    )
        : Center(child: CircularProgressIndicator(color: Colors.green.shade700,));
  }
}

