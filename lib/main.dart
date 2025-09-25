import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lacrosse/features/SplashScreen/Presention/SplashScreen.dart';
import 'package:lacrosse/features/accountPage/data/manager/cubit/Account_cubit.dart';
import 'package:lacrosse/features/auth/data/manager/cubit/auth_cubit.dart';
import 'package:lacrosse/features/auth/pressntation/loginPage.dart';
import 'package:lacrosse/features/auth/pressntation/regiserPage2.dart';
import 'package:lacrosse/features/home/data/manager/cubit/home_cubit.dart';
import 'package:lacrosse/features/layout/Tabs/BaseScreen.dart';
import 'package:lacrosse/features/notficationPage/presentation/notificationPage.dart';
import 'package:lacrosse/features/notficationPage/presentation/notification_page_manager.dart';
import 'package:lacrosse/features/orders/data/manager/cubit/OrderCubite.dart';
import 'package:lacrosse/features/orders/presentation/orders_page.dart';
import 'package:lacrosse/test.dart';
import 'package:lacrosse/test2.dart';
import 'data/Local/sharedPref/sharedPref.dart';
import 'data/remote/dio.dart';
import 'features/ActivitesPage/data/manager/cubit/activities_cubit.dart';

import 'features/NewsPage/data/manager/cubit/news_cubit.dart';

import 'features/auth/pressntation/registerPage1.dart';
import 'features/eventsPage/data/manager/cubit/manager_cubit.dart';

import 'features/notficationPage/data/manager/cubit/notificationcubit.dart';
import 'firebase_notification.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fcm= await NotificationService.instance.initialize();
  print(fcm);
  CacheHelper.saveData(key: "FcmToken", value: fcm);
  await EasyLocalization.ensureInitialized();
  await initializeDateFormatting('ar', null); // أو استخدم Platform.localeName لو عايز تلقائي

  await checkForRefreshToken();

  // String token = await CacheHelper.getData(key: "accessToken") ?? "";
  // print(token);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
            create: (_) => HomeCubit(DioService())
              ..fetchGameRuleData()
              ..fetchAdvertisement()
              ..fetchAboutUnionData() //..fetchAllPlayersData()..fetchAllmatches()..fetchAlltEAMS(), // توفير ActivitiesCubit باستخدام DioService
        ),
        BlocProvider<OrderCubit>(
            create: (_) => OrderCubit(
                DioService()) //..fetchAllPlayersData()..fetchAllmatches()..fetchAlltEAMS(), // توفير ActivitiesCubit باستخدام DioService
        ),
        BlocProvider<managerCubit>(
            create: (_) => managerCubit(
                DioService()) //..fetchAllPlayersData()..fetchAllmatches()..fetchAlltEAMS(), // توفير ActivitiesCubit باستخدام DioService
        ),
        BlocProvider<ActivitiesCubit>(
          create: (_) => ActivitiesCubit(DioService())
            ..getInternalEventForCurrentUser(date: DateTime.now()), // توفير ActivitiesCubit باستخدام DioService
        ),
        BlocProvider<NewsCubit>(
          create: (BuildContext context) => NewsCubit(DioService())
            ..fetchAllNewsData(), // توفير ActivitiesCubit باستخدام DioService
        ),
        BlocProvider<AccountCubit>(
          create: (BuildContext context) => AccountCubit(DioService())
            ..fetchAllQuestionData(), // توفير ActivitiesCubit باستخدام DioService
        ),
        BlocProvider<AuthCubit>(
            create: (BuildContext context) => AuthCubit(
                DioService()) //.()// توفير ActivitiesCubit باستخدام DioService
        ),
        BlocProvider<NotififcationsCubit>(
            create: (BuildContext context) => NotififcationsCubit(
                DioService())
        ),

        // يمكن إضافة مزودات إضافية (BlocProviders) هنا إذا لزم الأمر
      ],
      child: EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ar')],
          path: "assets/langs",
          startLocale: Locale('ar'),
          saveLocale: true,
          child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String? token = CacheHelper.getData(key: "accessToken");
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        // bottomNavigationBarTheme:const BottomNavigationBarThemeData(
        //  backgroundColor: Colors.white,
        //
        // ),
        primarySwatch: Colors.blue,
        fontFamily: 'DINNextLTW23',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
              color: Color(0xff185A3F)),
          bodyLarge: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),


      home:
     // CacheHelper.getData(key: "accessToken") == null  ?
      SplashScreen()
       //   : Basescreen(),

      //  home: Basescreen(),
    );
  }
}

 checkForRefreshToken() async{
  if( CacheHelper.getData(key: "refreshTokenExpiration")!=null) {
    print(CacheHelper.getData(
        key: "refreshTokenExpiration"));
    print(CacheHelper.getData(key: "refreshTokenExpiration"));

    String specificDateString = CacheHelper.getData(
        key: "refreshTokenExpiration");
    DateTime specificDate = DateTime.parse(specificDateString);

    DateTime today = DateTime.now();

    String todayFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSSS").format(
        today);
//    String formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSSS").format(now);
    print(todayFormatted);
    if (today.isBefore(specificDate)) {
      print(" تاريخ الانتهاء لم ياتى ");
    } else if (today.isAfter(specificDate)) {

    } else {
      print("تاريخ اليوم يساوي التاريخ المحدد.");
    }
  }
}