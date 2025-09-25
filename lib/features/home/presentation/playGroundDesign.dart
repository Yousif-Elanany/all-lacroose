import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/data/Local/sharedPref/sharedPref.dart';
import 'package:lacrosse/features/home/data/manager/cubit/home_cubit.dart';
import 'package:lacrosse/features/home/data/models/PlayGroundModel.dart';
import 'package:lacrosse/features/home/presentation/Map.dart';
import 'package:lacrosse/features/home/presentation/selectPlayGroundLocation.dart';

class PlayGroundPage extends StatefulWidget {
  const PlayGroundPage({super.key});

  @override
  State<PlayGroundPage> createState() => _PlayGroundPageState();
}

class _PlayGroundPageState extends State<PlayGroundPage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchPlayGround();
  }

  @override
  Widget build(BuildContext context) {
    // استدعاء الداتا أول ما الصفحة تبني

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
        ),
        title: Text(
          "All stadiums".tr(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          CacheHelper.getData(key: "roles")  == "Admin"  ?     IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              TextEditingController nameController = TextEditingController();
              double? selectedLat;
              double? selectedLng;

              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  final _formKey = GlobalKey<FormState>();
                  TextEditingController nameController =
                      TextEditingController();
                  double? selectedLat;
                  double? selectedLng;

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 16,
                      right: 16,
                      top: 16,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "addPlayGroundName".tr(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),

                          // =======================
                          // الفورم
                          // =======================
                          Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: "name".tr(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 12),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Required".tr();
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 15),

                          // =======================
                          // زر تحديد الموقع على الخريطة
                          // =======================
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[400],
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            icon: Icon(
                              Icons.location_on,
                              size: 24,
                              color: Colors.white,
                            ),
                            label: Text(
                              "addPlayGroundLocation".tr(),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SelectLocationMapScreen()),
                              );

                              if (result != null) {
                                selectedLat = result.latitude;
                                selectedLng = result.longitude;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("تم اختيار الموقع".tr())),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 15),

                          // =======================
                          // زر إضافة الملعب
                          // =======================
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(
                              "addPlayGround".tr(),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (selectedLat == null ||
                                    selectedLng == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("addPlayGroundLocation".tr())),
                                  );
                                  return;
                                }

                                // استدعاء الـ API لإضافة الملعب
                                await context.read<HomeCubit>().addPlayGround(
                                      name: nameController.text.trim(),
                                      lat: selectedLat.toString(),
                                      long: selectedLng.toString(),
                                    );

                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("add successfully".tr())),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                },
              ) ;
            },
          ) :SizedBox(),
        ],
      ),
      body: Column(
        children: [
          // الجزء العلوي (البار)
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.14,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage("assets/images/top bar.png"),
          //       fit: BoxFit.cover,
          //     ),
          //     gradient: LinearGradient(
          //       colors: [Colors.green.shade900, Colors.green.shade700],
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //     ),
          //   ),
          // ),
          // الـ ListView يبدأ بعد البار
          Expanded(
            child: BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) {
                if (state is FetchPlayGroundLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is FetchPlayGroundSuccess) {
                  final playgrounds = state.playGrounds;

                  if (playgrounds.isEmpty) {
                    return Center(child: Text("لا توجد ملاعب حالياً"));
                  }
                  if (state is AddPlayGroundSuccess) {
                    context.read<HomeCubit>().fetchPlayGround();
                  }
                  if (state is EditPlayGroundSuccess) {
                    context.read<HomeCubit>().fetchPlayGround();
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: playgrounds.length,
                    itemBuilder: (context, index) {
                      final pg = playgrounds[index];

                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          onTap: () {

                          },
                          contentPadding: const EdgeInsets.all(12),
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[100],
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/lacrosse 1@3x.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          title: Text(
                            pg.name ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize
                                .min, // مهم عشان الـ Row ما ياخدش كل المساحة
                            children: [
                              IconButton(
                                icon: Icon(Icons.location_on, size: 22),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => MapScreen(
                                        latitude:
                                        double.tryParse(pg.latitude ?? "0") ??
                                            0.0,
                                        longitude:
                                        double.tryParse(pg.longitude ?? "0") ??
                                            0.0,
                                        name: pg.name ?? "الملعب",
                                      ),
                                    ),
                                  ); // مثال على Bottom Sheet للتعديل
                                },
                              ),
                              SizedBox(width: 10),
                              CacheHelper.getData(key: "roles")  == "Admin" ?               IconButton(
                                icon: Icon(Icons.edit,
                                    color: Colors.blue, size: 22),
                                onPressed: () {
                                  // هنا تضيف كود تعديل الملعب
                                     showEditPlaygroundSheet(context, pg); // مثال على Bottom Sheet للتعديل
                                },
                              ) :SizedBox(),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
  void showEditPlaygroundSheet(BuildContext context, PlayGroundModel pg) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController nameController =
    TextEditingController(text: pg.name ?? "");
    double? selectedLat = double.tryParse(pg.latitude ?? "");
    double? selectedLng = double.tryParse(pg.longitude ?? "");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "تعديل الملعب".tr(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                // =======================
                // TextFormField للاسم
                // =======================
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "اسم الملعب".tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "من فضلك أدخل اسم الملعب".tr();
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15),

                // =======================
                // زر اختيار الموقع
                // =======================
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[400],
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: Icon(Icons.map, size: 24),
                  label: Text(
                    "حدد الموقع على الخريطة".tr(),
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SelectLocationMapScreen(
                            lat: selectedLat,
                            long: selectedLng,
                          )),
                    );

                    if (result != null) {
                      selectedLat = result.latitude;
                      selectedLng = result.longitude;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("تم اختيار الموقع".tr())),
                      );
                    }
                  },
                ),
                SizedBox(height: 15),

                // =======================
                // زر التحديث
                // =======================
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    "تحديث".tr(),
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (selectedLat == null || selectedLng == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "من فضلك حدد موقع الملعب على الخريطة".tr())),
                        );
                        return;
                      }

                      // استدعاء الـ API لتعديل الملعب
                      await context.read<HomeCubit>().editPlayGround(
                        id: pg.id,
                        name: nameController.text.trim(),
                        lat: selectedLat.toString(),
                        long: selectedLng.toString(),
                      );

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("تم تحديث الملعب بنجاح".tr())),
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
