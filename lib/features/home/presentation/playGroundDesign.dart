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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff185A3F),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
        ),
        title: Text(
          "All stadiums".tr(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          CacheHelper.getData(key: "roles") == "Admin"
              ? IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _showAddPlayGroundSheet(context);
            },
          )
              : const SizedBox(),
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is AddPlayGroundSuccess ||
              state is EditPlayGroundSuccess ||
              state is DeletePlayGroundSuccess) {
            context.read<HomeCubit>().fetchPlayGround();
          }
        },
        builder: (context, state) {
          if (state is FetchPlayGroundLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FetchPlayGroundSuccess) {
            final playgrounds = state.playGrounds;

            if (playgrounds.isEmpty) {
              return Center(child: Text("لا توجد ملاعب حالياً"));
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
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[100],
                        image: const DecorationImage(
                          image: AssetImage("assets/images/lacrosse 1@3x.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    title: Text(
                      pg.name ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.location_on, size: 22),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MapScreen(
                                  latitude:
                                  double.tryParse(pg.latitude ?? "0") ?? 0.0,
                                  longitude:
                                  double.tryParse(pg.longitude ?? "0") ?? 0.0,
                                  name: pg.name ?? "الملعب",
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        if (CacheHelper.getData(key: "roles") == "Admin")
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    color: Colors.blue, size: 22),
                                onPressed: () {
                                  _showEditPlaygroundSheet(context, pg);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.red, size: 22),
                                onPressed: () {
                                  _showDeleteDialog(context, pg.id!);
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  // ====================================================
  // 🟢 Bottom Sheet لإضافة ملعب جديد
  // ====================================================
  void _showAddPlayGroundSheet(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    double? selectedLat;
    double? selectedLng;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
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
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "addPlayGroundName".tr(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "name".tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
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
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[400],
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.location_on, color: Colors.white),
                      label: Text(
                        "addPlayGroundLocation".tr(),
                        style:
                        const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>  SelectLocationMapScreen()),
                        );
                        if (result != null) {
                          setModalState(() {
                            selectedLat = result.latitude;
                            selectedLng = result.longitude;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("تم اختيار الموقع".tr())),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        "addPlayGround".tr(),
                        style: const TextStyle(
                            fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (selectedLat == null || selectedLng == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                  Text("addPlayGroundLocation".tr())),
                            );
                            return;
                          }

                          await context.read<HomeCubit>().addPlayGround(
                            name: nameController.text.trim(),
                            lat: selectedLat.toString(),
                            long: selectedLng.toString(),
                          );

                          if (context.mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("add successfully".tr())),
                            );
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  // ====================================================
  // 🟡 Bottom Sheet لتعديل ملعب
  // ====================================================
  void _showEditPlaygroundSheet(BuildContext context, PlayGroundModel pg) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController nameController =
    TextEditingController(text: pg.name ?? "");
    double? selectedLat = double.tryParse(pg.latitude ?? "");
    double? selectedLng = double.tryParse(pg.longitude ?? "");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
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
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "تعديل الملعب".tr(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "اسم الملعب".tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 12),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "من فضلك أدخل اسم الملعب".tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[400],
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.map, size: 24),
                      label: Text(
                        "حدد الموقع على الخريطة".tr(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SelectLocationMapScreen(
                              lat: selectedLat,
                              long: selectedLng,
                            ),
                          ),
                        );
                        if (result != null) {
                          setModalState(() {
                            selectedLat = result.latitude;
                            selectedLng = result.longitude;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("تم اختيار الموقع".tr())),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        "تحديث".tr(),
                        style: const TextStyle(
                            fontSize: 16, color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (selectedLat == null || selectedLng == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "من فضلك حدد موقع الملعب على الخريطة"
                                          .tr())),
                            );
                            return;
                          }

                          await context.read<HomeCubit>().editPlayGround(
                            id: pg.id,
                            name: nameController.text.trim(),
                            lat: selectedLat.toString(),
                            long: selectedLng.toString(),
                          );

                          if (context.mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                  Text("تم تحديث الملعب بنجاح".tr())),
                            );
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  // ====================================================
  // 🔴 Dialog لحذف ملعب
  // ====================================================
  void _showDeleteDialog(BuildContext context, int playGroundId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("delete_team_title".tr()),
        content: Text("delete_team".tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("cancel".tr()),
          ),
          TextButton(
            onPressed: () async {
              await context.read<HomeCubit>().deletePlayGround(id: playGroundId);
              if (context.mounted) Navigator.pop(context);
            },
            child:
            Text("delete".tr(), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
