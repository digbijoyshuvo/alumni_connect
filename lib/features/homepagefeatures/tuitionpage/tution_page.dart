import 'package:alumni_connect/data/database/tution_data.dart';
import 'package:alumni_connect/routes/route_names.dart';
import 'package:alumni_connect/theme/app_color.dart';
import 'package:alumni_connect/widgets/custom_snackbar.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TuitionPage extends StatefulWidget {
  const TuitionPage({super.key});

  @override
  State<TuitionPage> createState() => _TuitionPageState();
}

class _TuitionPageState extends State<TuitionPage> {
  List<Document> tuition = [];
  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    getAllTuition().then((value) {
      tuition = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Column(
        children: [
          // Custom AppBar Style
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                // colors:  [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                // colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
                // colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
                colors: [Color(0xFF3A1C71), Color(0xFFD76D77), Color(0xFFFFAF7B)],
                // colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                // colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],

                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 8,),
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      "Available Tuition's",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
              ],
            ),

          ),
          SizedBox(height: 20,),
          // Tuition List
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onTap: () => CustomSnackBar.showSuccess(
                            context, "Please Go to Profile And Delete or Update the Tuition"),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff141A31), Color(0xff1F2B44)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tuition No :  ${index + 1}\n",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.amberAccent,
                                  ),
                                ),
                                Text(
                                  "Subjects : ${tuition[index].data["subjects"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                Text(
                                  "Location : ${tuition[index].data["location"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Text(
                                  "Salary : ${tuition[index].data["salary"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.orangeAccent,
                                  ),
                                ),
                                Text(
                                  "Contact : ${tuition[index].data["contactInfo"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.orangeAccent,
                                  ),
                                ),
                                Text(
                                  "${tuition[index].data["extra_info"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    childCount: tuition.length,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.pushNamed(RouteNames.addTuition);
          refresh();
        },
        backgroundColor: AppColor.appColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
