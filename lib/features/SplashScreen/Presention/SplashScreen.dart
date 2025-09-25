// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:lacrosse/features/layout/Tabs/BaseScreen.dart';
//
// import '../../../data/Local/sharedPref/sharedPref.dart';
// import '../../auth/pressntation/loginPage.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   late Timer _timer;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );
//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
//     _controller.forward();
//
//     _timer = Timer(Duration(seconds: 2), () {
//       if (mounted) {
//         Navigator.of(context).pushReplacement(
//           PageRouteBuilder(
//             transitionDuration: Duration(seconds: 1),
//             pageBuilder: (context, animation, secondaryAnimation) =>
//             CacheHelper.getData(key: "accessToken") == null ? LoginPage() : Basescreen(),
//             transitionsBuilder: (context, animation, secondaryAnimation, child) {
//               const begin = Offset(-1, 0);
//               const end = Offset.zero;
//               const curve = Curves.easeInOut;
//
//               var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//               var offsetAnimation = animation.drive(tween);
//
//               return SlideTransition(position: offsetAnimation, child: child);
//             },
//           ),
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _timer.cancel(); // إلغاء المؤقت عند التخلص من الشاشة
//     super.dispose();
//   }
//  //  @override
//  //  void initState() {
//  //    super.initState();
//  //
//  //    // Preload images to avoid lag during the transition
//  // //   precacheImage(AssetImage('assets/images/Screenshot_1.png'), context);
//  // //   precacheImage(AssetImage('assets/images/slf2.png'), context);
//  //
//  //    // Initialize animation
//  //    _controller = AnimationController(
//  //      duration: const Duration(seconds: 2),
//  //      vsync: this,
//  //    );
//  //    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
//  //
//  //    _controller.forward();
//  //
//  //    // Navigate to the Home Screen after 5 seconds
//  //    Timer(Duration(seconds: 5), () {
//  //      Navigator.of(context).pushReplacement(
//  //        PageRouteBuilder(
//  //          transitionDuration: Duration(seconds: 1), // Reduced transition duration for better responsiveness
//  //          pageBuilder: (context, animation, secondaryAnimation) => CacheHelper.getData(key: "accessToken") == null  ? LoginPage() : Basescreen(),
//  //          transitionsBuilder: (context, animation, secondaryAnimation, child) {
//  //            const begin = Offset(-1, 0); // Start from left
//  //            const end = Offset.zero; // End at center
//  //            const curve = Curves.easeInOut; // Smooth transition effect
//  //
//  //            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//  //            var offsetAnimation = animation.drive(tween);
//  //
//  //            return SlideTransition(
//  //              position: offsetAnimation,
//  //              child: child,
//  //            );
//  //          },
//  //        ),
//  //      );
//  //    });
//  //  }
//  //
//  //  @override
//  //  void dispose() {
//  //    _controller.dispose();
//  //    super.dispose();
//  //  }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FadeTransition(
//         opacity: _animation,
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/Screenshot_1.png'), // Background image
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Image.asset(
//                   'assets/images/slf2.png', // Logo image
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lacrosse/features/layout/Tabs/BaseScreen.dart';
import '../../../data/Local/sharedPref/sharedPref.dart';
import '../../auth/pressntation/loginPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    checkTokenAndNavigate(); // 👈 شغّل الفانكشن الجديدة
  }
  void checkTokenAndNavigate() async {
    await Future.delayed(Duration(seconds: 2));
    var token = CacheHelper.getData(key: "accessToken");
    print("توكن على الجهاز الحقيقي: $token"); // 👈 اطبع التوكن هنا

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => token == null ? LoginPage() : Basescreen(),
      ),
    );
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //
  //   // ✅ تحميل الصور مسبقًا هنا لأن `context` أصبح جاهزًا
  //   precacheImage(AssetImage('assets/images/Screenshot_1.png'), context);
  //   precacheImage(AssetImage('assets/images/slf2.png'), context);
  //
  //   // ✅ الانتقال إلى الشاشة الرئيسية بعد التأكد من تحميل البيانات
  //   Future.delayed(Duration(seconds: 2), () {
  //     if (mounted) {
  //       Navigator.of(context).pushReplacement(
  //         PageRouteBuilder(
  //           transitionDuration: Duration(seconds: 1),
  //           pageBuilder: (context, animation, secondaryAnimation) =>
  //           CacheHelper.getData(key: "accessToken") == null ? LoginPage() : Basescreen(),
  //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //             const begin = Offset(-1, 0);
  //             const end = Offset.zero;
  //             const curve = Curves.easeInOut;
  //
  //             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //             var offsetAnimation = animation.drive(tween);
  //
  //             return SlideTransition(position: offsetAnimation, child: child);
  //           },
  //         ),
  //       );
  //     }
  //   });
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Screenshot_1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Image.asset('assets/images/slf2.png'),
          ),
        ),
      ),
    );
  }
}