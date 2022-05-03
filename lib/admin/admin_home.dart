import 'package:egy_health_record/admin/viruses.dart';
import 'package:egy_health_record/pages/homepage.dart';
import 'package:flutter/material.dart';

import 'add_user.dart';
import '../admin/cronic_diseases.dart';
import 'edit_user.dart';
import 'medications_drugs.dart';
import 'notes.dart';
import 'operations.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('EGY HEALTH RECORD')),
        drawer: Container(
          child: Column(
            children: [
              Container(
                color: Colors.grey[100],
                child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 170,
                        color: const Color(0xff1d3444),
                        child: Image.asset(
                          'assets/images/egy_logo.png',
                          height: 100,
                          width: 100,
                        )),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Viruses()));
                      },
                      leading: const Icon(Icons.coronavirus),
                      title: const Text('اللقاحات والاوبئة'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 18,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChronicDiseases()));
                      },
                      leading: const Icon(Icons.access_time),
                      title: const Text('الامراض المزمنة'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 18,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const MedicationsDrugsPage()));
                      },
                      leading: const Icon(Icons.auto_fix_high),
                      title: const Text('العلاجات والادوية للمريض'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 18,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Operations()));
                      },
                      leading: const Icon(Icons.content_cut),
                      title: const Text('العمليات الجراحية'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 18,
                      ),
                    ),

                    const Divider(),ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                            const Notes()));
                      },
                      leading: const Icon(Icons.info_outline),
                      title: const Text('الملاحظات الطبية'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 18,
                      ),
                    ),
                    const Divider(),ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const HomePage()));
                      },
                     title: const Text('تسجيل خروج'),
                      trailing: const Icon(
                        Icons.logout,
                        size: 18,
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ],
          ),
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.7,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Divider(),
              const SizedBox(
                height: 142,
              ),
              const Text('اختر الخيار'),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => AddUser()));
                },
                child: Container(
                  child: const Center(
                    child: Text(
                      'أضافة مواطن',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(60, 12, 60, 12),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Colors.blue),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => EditUser()));
                },
                child: Container(
                  child: const Center(
                    child: Text(
                      'تعديل بيانات',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(60, 12, 60, 12),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
