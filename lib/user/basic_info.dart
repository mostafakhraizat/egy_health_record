import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  String id = '';
  String nationality = '';
  String place = '';
  String fullname = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('المعلومات الاساسية'),
      ),
      body: Center(
        child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            FirebaseDatabase datbase = FirebaseDatabase.instance;
            final ref = datbase.ref('Users');
            final a = ref.child(widget.id).get();
            a.then((value) {
              if (value.value == null) {

              } else {
                setState(() {
                  Map<String, dynamic> data =
                  jsonDecode(jsonEncode(value.value));
                  id = data['id'];
                  nationality = data['nationality'];
                  place = data['place'];
                  fullname = data['fullname'];
                });
              }
            });
            return  Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child:Row(
                              children: const[
                                Text(''),
                                Icon(Icons.check,color: Colors.green,)
                              ],
                            )
                        ),
                        Text(id + '   :الرقم القومي')
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(fullname + '   :الاسم الكامل'),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(place + '   :المحافظة'),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(nationality + '   :الجنسية '),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}
