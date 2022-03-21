import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasminggu4/globals/datas.dart';

import 'register.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late SharedPreferences pref;

  String name = '', city = '', pass = '', conf_pass = '';

  void getData() async {
    pref = await SharedPreferences.getInstance();

    setState(() {
      name = pref.getString('name') ?? 'Jaka Sembung';
      city = pref.getString('city') ?? 'Bandung';
      pass = pref.getString('pass') ?? 'no pass';
      conf_pass = pref.getString('confirmpass') ?? 'no confirmpass';
    });
  }

  void logout() async {
    pref.clear();
    print('Pref cleared, you are logged out');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => RegisterView(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 275.0,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    image: DecorationImage(
                      image: NetworkImage("$profileUrl"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 275.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.centerLeft,
                      end: FractionalOffset.centerRight,
                      colors: [
                        Colors.purple.withOpacity(.9),
                        Colors.pink.withOpacity(.9),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'DancingScript',
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'UI/UX Designer | Flutter Developer',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.room,
                            color: Colors.white54,
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "$city, Indonesia",
                            style: TextStyle(color: Colors.white54),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 205.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(100),
                      elevation: 3,
                      child: CircleAvatar(
                        radius: 69.0,
                        backgroundColor: Colors.white,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: CircleAvatar(
                            radius: 66.0,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: NetworkImage(
                              "$profileUrl",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 30.0),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProfileStatsWidget(
                    title: "Posts",
                    score: "324",
                  ),
                  ProfileStatsWidget(title: "Followers", score: "4323"),
                  ProfileStatsWidget(title: "Following", score: "2938"),
                ],
              ),
            ),
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 350.0,
                      child: Center(
                        child: Card(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text("About me"),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Text(
                                    'Saya seorang UI/UX dan Flutter Developer yang berpengalaman mendesign dan menerapkan design ke dalam aplikasi cross platform dengan menggunakan flutter framework\n\nUntuk Design, saya menggunakan aplikasi Figma dan Photoshop untuk mengedit gambar dan mengatur layout'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: InkWell(
                        onTap: () => logout(),
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 250.0,
                          ),
                          padding: const EdgeInsets.all(15.0),
                          height: 50.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1.5,
                                color: Colors.black54,
                                offset: Offset(.5, .5),
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.powerOff,
                                color: Colors.white,
                                size: 15,
                              ),
                              Text(
                                "Logout",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProfileStatsWidget extends StatelessWidget {
  final String score, title;

  const ProfileStatsWidget({
    Key? key,
    required this.title,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$score",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "$title",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
