import 'package:egy_health_record/user/user_notes.dart';
import 'package:egy_health_record/user/users_viruses.dart';
import 'package:flutter/material.dart';
import 'basic_info.dart';
import 'chronic_diseases_user.dart';
import 'medications_users.dart';
import 'operations_user.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('User Interface')),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 120,
                  child: Center(
                    child: Text(
                      'الخيارات',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ChronicDiseasesUser(id: widget.id);
                        }));
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        padding: const EdgeInsets.all(16),
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            'الامراض\n المزمنة',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return BasicInfo(id: widget.id);
                        }));
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        padding: const EdgeInsets.all(16),
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            'المعلومات\n الاساسية',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                const Divider(),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return OperationsUser(id: widget.id);
                        }));
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        padding: const EdgeInsets.all(16),
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            'العمليات\n الجراحية',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return VirusesUser(id: widget.id);
                        }));
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        padding: const EdgeInsets.all(16),
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            'اللقاحات \n والأوبئة',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return MedicationsUsers(id: widget.id);
                        }));
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            'الادوية الخاصة\n لامريض',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return UserNotes(id: widget.id);
                        }));
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        padding: const EdgeInsets.all(16),
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            'الملاحظات \n الطبية',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
