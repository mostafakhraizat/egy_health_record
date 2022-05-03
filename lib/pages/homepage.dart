import 'package:flutter/material.dart';

import '../login/admin+_login.dart';
import '../login/user_login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:   [
              const SizedBox(height: 150,
              child: Center(
                child: Text(
                  'اهلا بك',style: TextStyle(color: Colors.black,fontSize: 32,fontWeight: FontWeight.w900),
                ),
              ),),
              const  Divider(),
              const    Text('EGY HEALTH RECORD',style: TextStyle(
                fontSize: 32
              ),),
              const  Divider(),
              const SizedBox(height: 42,),
              const Text('اختر المستخدم'),
              
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UserSignIn()));
                },
                child: Container(
                  child:const Center(
                    child: Text('User',style: TextStyle(
                        color: Colors.white,fontSize: 22
                    ),),
                  ),
                  height: 60,
                  margin:const EdgeInsets.fromLTRB(60, 12, 60, 12),
                  decoration:const  BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: Colors.blue
                  ),
                ),
              ),
              const  SizedBox(height: 22,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminSignIn()));
                },
                child: Container(
                  child:const Center(
                    child: Text('Admin',style: TextStyle(
                      color: Colors.white,fontSize: 22
                    ),),
                  ),
                  height: 60,
                  margin:const EdgeInsets.fromLTRB(60, 12, 60, 12),
                  decoration:const  BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Colors.blue
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
