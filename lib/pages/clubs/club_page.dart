// home_screen.dart

import 'package:cse_university_app/pages/clubs/model/club_model.dart';
import 'package:cse_university_app/pages/clubs/service/club_service.dart';
import 'package:cse_university_app/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class ClubPage extends StatefulWidget {
  @override
  _ClubPageState createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  late Future<List<Club>> futureClubs;

  @override
  void initState() {
    super.initState();
    futureClubs = ClubService().getClubs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kulüpler',
          style: CustomColors.barStyle,
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Club>>(
          future: futureClubs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<Club> clubs = snapshot.data!;
              return ListView.builder(
                itemCount: clubs.length,
                itemBuilder: (context, index) {
                  Club club = clubs[index];
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: CustomColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            useSafeArea: true,
                            context: context,
                            builder: (context) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Center(
                                  child: InteractiveViewer(
                                    maxScale: 5.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: CustomColors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25))),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                club.clubName,
                                                style: CustomColors.cardStyle,
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            color: CustomColors.darkPurple,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Kulüp Yönetici: ",
                                                  style:
                                                      CustomColors.cardSubtitle,
                                                ),
                                                Text(club.clubLider),
                                                Text(
                                                  "Yönetici mail: ",
                                                  style:
                                                      CustomColors.cardSubtitle,
                                                ),
                                                Text(club.liderMail),
                                                Text(
                                                  "Yönetici iletişim:",
                                                  style:
                                                      CustomColors.cardSubtitle,
                                                ),
                                                Text(club.liderTel),
                                                Text(
                                                  "Danışman: ",
                                                  style:
                                                      CustomColors.cardSubtitle,
                                                ),
                                                Text(club.daniAd),
                                                Text(
                                                  "Danışman Mail: ",
                                                  style:
                                                      CustomColors.cardSubtitle,
                                                ),
                                                Text(club.daniMail),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 60,
                                height: 60,
                                child: CircleAvatar(
                                  backgroundColor: CustomColors.red,
                                  child: club.clubLogo.isNotEmpty
                                      ? ImageNetwork(
                                          image: club.clubLogo,
                                          height: 150,
                                          width: 150,
                                          duration: 1500,
                                          curve: Curves.easeIn,
                                          onPointer: true,
                                          debugPrint: false,
                                          fullScreen: false,
                                          fitAndroidIos: BoxFit.cover,
                                          fitWeb: BoxFitWeb.cover,
                                          borderRadius:
                                              BorderRadius.circular(70),
                                          onLoading:
                                              const CircularProgressIndicator(
                                            color: Colors.indigoAccent,
                                          ),
                                          onError: const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                          onTap: () {
                                            showDialog(
                                              useSafeArea: true,
                                              context: context,
                                              builder: (context) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Center(
                                                    child: InteractiveViewer(
                                                      maxScale: 5.0,
                                                      child: Image.network(
                                                        club.clubLogo,
                                                        fit: BoxFit.fill,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return Image.network(
                                                              "https://www.istun.edu.tr/templates/default/assets/images/istun.logo.white.png");
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          "assets/white.png",
                                        ),
                                ),
                                decoration: BoxDecoration(
                                  color: CustomColors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Text(club.clubName),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text('No data');
            }
          },
        ),
      ),
    );
  }
}
