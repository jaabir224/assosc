import 'package:assosc/models/membre_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/custom_style.dart';

import 'widgets/user_info_item.dart';

class DetailMembre extends StatefulWidget {
  const DetailMembre({super.key});
  static String path = "/detail_membre";

  @override
  State<DetailMembre> createState() => _DetailMembreState();
}

class _DetailMembreState extends State<DetailMembre> {
  MembreModel? member;

  bool isCharging = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    member = args['member'];

    setState(() {});
  }

  _refreshIndex() {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    color: CustomStyle.secondColor.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                FontAwesomeIcons.arrowLeft,
                                color: CustomStyle.night,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width:
                                    MediaQuery.of(context).size.height * 0.12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: CustomStyle.secondColor,
                                  ),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/medecin_2.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${member!.prenom} ${member!.nom}",
                                style: TextStyle(
                                  color: CustomStyle.night,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          UserInfoItem(
                            title: "Adresse",
                            value: member!.adresse,
                          ),
                          UserInfoItem(
                            title: "Email",
                            value: member!.email,
                          ),
                          UserInfoItem(
                            title: "Téléphone",
                            value: member!.telephone,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
