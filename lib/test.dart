// // import 'package:dio/dio.dart';
// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// //
// // class DioClient {
// //   final Dio _dio = Dio();
// //   final _storage = const FlutterSecureStorage(); // لتخزين الرموز بأمان
// //
// //   DioClient() {
// //     _dio.options.baseUrl = "https://example.com/api"; // ضع رابط الـ API الخاص بك هنا
// //     _dio.interceptors.add(InterceptorsWrapper(
// //       onRequest: (options, handler) async {
// //         // إضافة Access Token إلى كل طلب
// //         final accessToken = await _storage.read(key: "access_token");
// //         if (accessToken != null) {
// //           options.headers["Authorization"] = "Bearer $accessToken";
// //         }
// //         return handler.next(options);
// //       },
// //       onError: (DioError error, handler) async {
// //         if (error.response?.statusCode == 401) {
// //           // إذا انتهت صلاحية التوكن
// //           final isRefreshed = await _refreshToken();
// //           if (isRefreshed) {
// //             // إعادة المحاولة بعد تحديث التوكن
// //             final newRequest = await _retryRequest(error.requestOptions);
// //             return handler.resolve(newRequest);
// //           }
// //         }
// //         return handler.next(error); // إذا كان الخطأ غير متعلق بالتوكن
// //       },
// //     ));
// //   }
// //
// //   // تحديث التوكن باستخدام Refresh Token
// //   Future<bool> _refreshToken() async {
// //     try {
// //       final refreshToken = await _storage.read(key: "refresh_token");
// //       if (refreshToken == null) return false;
// //
// //       final response = await _dio.post("/refresh-token", data: {
// //         "refresh_token": refreshToken,
// //       });
// //
// //       if (response.statusCode == 200) {
// //         final newAccessToken = response.data["access_token"];
// //         final newRefreshToken = response.data["refresh_token"];
// //
// //         // تخزين الرموز الجديدة
// //         await _storage.write(key: "access_token", value: newAccessToken);
// //         await _storage.write(key: "refresh_token", value: newRefreshToken);
// //         return true;
// //       }
// //     } catch (e) {
// //       print("Failed to refresh token: $e");
// //     }
// //     return false;
// //   }
// //
// //   // إعادة إرسال الطلب الأصلي
// //   Future<Response> _retryRequest(RequestOptions requestOptions) async {
// //     final newAccessToken = await _storage.read(key: "access_token");
// //
// //     final options = Options(
// //       method: requestOptions.method,
// //       headers: {
// //         ...requestOptions.headers,
// //         "Authorization": "Bearer $newAccessToken", // إضافة التوكن الجديد
// //       },
// //     );
// //
// //     return await _dio.request(
// //       requestOptions.path,
// //       options: options,
// //       data: requestOptions.data,
// //       queryParameters: requestOptions.queryParameters,
// //     );
// //   }
// //
// //   // مثال: إرسال طلب GET
// //   Future<Response> get(String path) async {
// //     return await _dio.get(path);
// //   }
// // }
// //
// // void main() async {
// //   final dioClient = DioClient();
// //
// //   try {
// //     final response = await dioClient.get("/protected-resource");
// //     print("Response: ${response.data}");
// //   } catch (e) {
// //     print("Error: $e");
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
//
// class ConnectivityCheckPage extends StatefulWidget {
//   @override
//   _ConnectivityCheckPageState createState() => _ConnectivityCheckPageState();
// }
//
// class _ConnectivityCheckPageState extends State<ConnectivityCheckPage> {
//   late Connectivity _connectivity;
//   ConnectivityResult _connectionStatus = ConnectivityResult.none;
//   bool _isConnected = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _connectivity = Connectivity();
//
//     // التحقق من حالة الاتصال في البداية
//     _checkConnection();
//
//     // الاستماع للتغييرات في الاتصال
//     _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//       // عند حدوث تغيير في الاتصال، نقوم بتحديث الحالة
//       _checkConnection(result);
//     });
//   }
//
//   // التحقق من حالة الاتصال
//   Future<void> _checkConnection([ConnectivityResult? result) async {
//     result ??= await _connectivity.checkConnectivity(); // الحصول على حالة الاتصال الحالية
//     setState(() {
//       _connectionStatus = result;
//       _isConnected = result != ConnectivityResult.none;
//     });
//   }
//
//   // إعادة تحميل الصفحة (إعادة بناء الواجهة)
//   void _reloadPage() {
//     setState(() {
//       // هنا يمكنك إضافة منطق لتحديث البيانات إذا لزم الأمر
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('التحقق من الاتصال')),
//       body: Center(
//         child: _isConnected
//             ? Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.wifi, size: 50, color: Colors.green),
//             Text('أنت متصل بالإنترنت!', style: TextStyle(fontSize: 20)),
//             ElevatedButton(
//               onPressed: _reloadPage,
//               child: Text('إعادة تحميل الصفحة'),
//             ),
//           ],
//         )
//             : Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.signal_wifi_off, size: 50, color: Colors.red),
//             Text('لا يوجد اتصال بالإنترنت', style: TextStyle(fontSize: 20)),
//             ElevatedButton(
//               onPressed: _reloadPage,
//               child: Text('إعادة المحاولة'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
////////////////

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
// import 'dart:io';
//
// class MediaPickerScreen extends StatefulWidget {
//   @override
//   _MediaPickerScreenState createState() => _MediaPickerScreenState();
// }
//
// class _MediaPickerScreenState extends State<MediaPickerScreen> {
//   final ImagePicker _picker = ImagePicker();
//   List<File> _mediaFiles = [];
//   Map<String, VideoPlayerController> _videoControllers = {};
//
//   Future<void> _pickMedia(ImageSource source, bool isVideo) async {
//     final pickedFile = await (isVideo
//         ? _picker.pickVideo(source: source)
//         : _picker.pickImage(source: source));
//     if (pickedFile != null) {
//       final file = File(pickedFile.path);
//       setState(() {
//         _mediaFiles.add(file);
//         if (isVideo) {
//           final controller = VideoPlayerController.file(file)
//             ..initialize().then((_) {
//               setState(() {});
//             });
//           _videoControllers[file.path] = controller;
//         }
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _videoControllers.values) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Horizontal Media List'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () => _pickMedia(ImageSource.gallery, false),
//                 child: Text('Pick Image'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _pickMedia(ImageSource.gallery, true),
//                 child: Text('Pick Video'),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 200, // تحديد الارتفاع
//             child: Expanded(
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: _mediaFiles.length,
//                 itemBuilder: (context, index) {
//                   final file = _mediaFiles[index];
//                   final isVideo = file.path.endsWith(".mp4") || file.path.endsWith(".mov");
//                   if (isVideo) {
//                     final controller = _videoControllers[file.path];
//                     return SizedBox(
//                       width: 200, // عرض العنصر 200 بكسل
//                       height: 200, // ارتفاع العنصر 200 بكسل
//                       child: controller != null && controller.value.isInitialized
//                           ? Stack(
//                         children: [
//                           // Video Player
//                           FittedBox(
//                             fit: BoxFit.cover, // التأكد من أن الفيديو يغطي كامل الحجم
//                             child: AspectRatio(
//                               aspectRatio: controller.value.aspectRatio,
//                               child: VideoPlayer(controller),
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 8,
//                             right: 8,
//                             child: FloatingActionButton(
//                               mini: true,
//                               onPressed: () {
//                                 setState(() {
//                                   controller.value.isPlaying
//                                       ? controller.pause()
//                                       : controller.play();
//                                 });
//                               },
//                               child: Icon(
//                                 controller.value.isPlaying
//                                     ? Icons.pause
//                                     : Icons.play_arrow,
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                           : Center(child: CircularProgressIndicator()),
//                     );
//                   } else {
//                     return SizedBox(
//                       width: 200, // عرض العنصر
//                       height: 200, // ارتفاع العنصر
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Image.file(
//                           file,
//                           fit: BoxFit.cover, // التأكد من تغطية كامل المساحة
//                         ),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ),
//           )
//
//         ],
//       ),
//     );
//   }
// }
////////////////////////////////////////
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
//
//
// class MediaPickerScreen extends StatefulWidget {
//   @override
//   _MediaPickerScreenState createState() => _MediaPickerScreenState();
// }
//
// class _MediaPickerScreenState extends State<MediaPickerScreen> {
//   final ImagePicker _picker = ImagePicker();
//   List<XFile> mediaFiles = []; // قائمة لتخزين الصور أو الفيديوهات
//   List<VideoPlayerController?> videoControllers = []; // تخزين وحدات تحكم الفيديو
//
//   Future<void> pickMedia(ImageSource source, {bool isVideo = false}) async {
//     // لالتقاط صورة أو فيديو
//     final XFile? pickedFile = await _picker.pickVideo(source: source);
//
//     if (pickedFile != null) {
//       setState(() {
//         mediaFiles.add(pickedFile);
//         if (pickedFile.path.endsWith('.mp4')) {
//           // إنشاء وحدة تحكم فيديو
//           videoControllers.add(VideoPlayerController.file(File(pickedFile.path))
//             ..initialize().then((_) {
//               setState(() {}); // إعادة بناء واجهة المستخدم بعد التهيئة
//             }));
//         } else {
//           videoControllers.add(null); // صورة
//         }
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     // تنظيف موارد الفيديو عند إنهاء الشاشة
//     for (var controller in videoControllers) {
//       controller?.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Media Picker with Video"),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // قائمة الصور/الفيديوهات الأفقي
//           SizedBox(
//             height: 150,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: mediaFiles.length,
//               itemBuilder: (context, index) {
//                 final file = mediaFiles[index];
//                 final videoController = videoControllers[index];
//
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: file.path.endsWith('.mp4') && videoController != null
//                       ? GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         // تشغيل أو إيقاف الفيديو
//                         if (videoController.value.isPlaying) {
//                           videoController.pause();
//                         } else {
//                           videoController.play();
//                         }
//                       });
//                     },
//                     child: Container(
//                       width: 150,
//                       height: 150,
//                       color: Colors.black,
//                       child: Stack(
//                         children: [
//                           VideoPlayer(videoController),
//                           if (!videoController.value.isPlaying)
//                             Center(
//                               child: Icon(
//                                 Icons.play_arrow,
//                                 color: Colors.white,
//                                 size: 50,
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   )
//                       : Image.file(
//                     File(file.path),
//                     fit: BoxFit.cover,
//                     width: 150,
//                     height: 150,
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 20),
//           // أزرار التقاط الصورة أو الفيديو
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton.icon(
//                 onPressed: () => pickMedia(ImageSource.gallery),
//                 icon: Icon(Icons.video_library),
//                 label: Text("اختيار فيديو"),
//               ),
//               const SizedBox(width: 10),
//               ElevatedButton.icon(
//                 onPressed: () => pickMedia(ImageSource.camera),
//                 icon: Icon(Icons.videocam),
//                 label: Text("التقاط فيديو"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
////
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';


class MediaPickerScreen extends StatefulWidget {
  @override
  _MediaPickerScreenState createState() => _MediaPickerScreenState();
}

class _MediaPickerScreenState extends State<MediaPickerScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> mediaFiles = []; // قائمة الصور والفيديوهات
  List<VideoPlayerController?> videoControllers = []; // وحدات تحكم الفيديو

  Future<void> pickMedia() async {

    // السماح باختيار صورة أو فيديو من المعرض
    final XFile? pickedFile = await _picker.pickMedia();

    if (pickedFile != null) {
      setState(() {
        mediaFiles.add(pickedFile);

        // إذا كان الملف فيديو
        if (pickedFile.path.endsWith('.mp4')) {
          final controller =
          VideoPlayerController.file(File(pickedFile.path)); // وحدة التحكم
          controller.initialize().then((_) {
            setState(() {}); // إعادة البناء بعد التهيئة
          });
          videoControllers.add(controller);
        } else {
          // إذا كان الملف صورة
          videoControllers.add(null);
        }
      });
    }
  }

  @override
  void dispose() {
    // تنظيف موارد الفيديو عند التخلص من الشاشة
    for (var controller in videoControllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Picker'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // قائمة أفقية للصور والفيديوهات
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mediaFiles.length,
              itemBuilder: (context, index) {
                final file = mediaFiles[index];
                final videoController = videoControllers[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: file.path.endsWith('.mp4') && videoController != null
                      ? GestureDetector(
                    onTap: () {
                      setState(() {
                        // تشغيل أو إيقاف الفيديو
                        if (videoController.value.isPlaying) {
                          videoController.pause();
                        } else {
                          videoController.play();
                        }
                      });
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: VideoPlayer(videoController),
                        ),
                        if (!videoController.value.isPlaying)
                          const Center(
                            child: Icon(
                              Icons.play_circle_fill,
                              color: Colors.black,
                              size: 50,
                            ),
                          ),
                      ],
                    ),
                  )
                      : Image.file(
                    File(file.path),
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: pickMedia,
            icon: const Icon(Icons.add),
            label: const Text('اختيار صورة/فيديو'),
          ),
        ],
      ),
    );
  }
}



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('BottomSheet + Keyboard Overflow')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true, // Allows full-screen height
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => const BottomSheetContent222(),
              );
            },
            child: const Text("Open Bottom Sheet"),
          ),
        ),
      ),
    );
  }
}

class BottomSheetContent222 extends StatelessWidget {
  const BottomSheetContent222({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom, // Moves sheet up with keyboard
      ),
      child: SingleChildScrollView( // Makes content scrollable
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Enter Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Enter Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Submit"),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}