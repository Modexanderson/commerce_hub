import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../box_switch_tile.dart';
import '../../../constants.dart';
import '../../../helpers/config.dart';
import '../../../size_config.dart';
import 'gradient_container.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String canvasColor =
      Hive.box('settings').get('canvasColor', defaultValue: 'Grey') as String;
  String cardColor =
      Hive.box('settings').get('cardColor', defaultValue: 'Grey900') as String;
  String theme =
      Hive.box('settings').get('theme', defaultValue: 'Default') as String;
  Map userThemes =
      Hive.box('settings').get('userThemes', defaultValue: {}) as Map;

  String themeColor =
      Hive.box('settings').get('themeColor', defaultValue: 'Indigo') as String;
  int colorHue = Hive.box('settings').get('colorHue', defaultValue: 400) as int;

  void switchToCustomTheme() {
    const custom = 'Custom';
    if (theme != custom) {
      currentTheme.setInitialTheme(custom);
      setState(
        () {
          theme = custom;
        },
      );
    }
  }

  final MyTheme currentTheme = GetIt.I<MyTheme>();
  @override
  Widget build(BuildContext context) {
    final List<String> userThemesList = <String>[
      'Default',
      ...userThemes.keys.map((theme) => theme as String),
      'Custom',
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(CupertinoIcons.back),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(screenPadding)),
          child: Column(
            children: [
              BoxSwitchTile(
                title: Text(
                  'Switch Mode',
                ),
                keyName: 'darkMode',
                defaultValue: true,
                onChanged: (bool val, Box box) {
                  box.put(
                    'useSystemTheme',
                    false,
                  );
                  currentTheme.switchTheme(
                    isDark: val,
                    useSystemTheme: false,
                  );
                  switchToCustomTheme();
                },
              ),
              BoxSwitchTile(
                title: Text(
                  'Use System Theme',
                ),
                keyName: 'useSystemTheme',
                defaultValue: false,
                onChanged: (bool val, Box box) {
                  currentTheme.switchTheme(useSystemTheme: val);
                  switchToCustomTheme();
                },
              ),
              ListTile(
                            title: Text(
                              'Accent',
                            ),
                            subtitle: Text('$themeColor, $colorHue'),
                            trailing: Padding(
                              padding: const EdgeInsets.all(
                                10.0,
                              ),
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    5.0,
                                  ),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[900]!,
                                      blurRadius: 5.0,
                                      offset: const Offset(
                                        0.0,
                                        3.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                isDismissible: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) {
                                  final List<String> colors = [
                                    'Purple',
                                    'Deep Purple',
                                    'Indigo',
                                    'Blue',
                                    'Light Blue',
                                    'Cyan',
                                    'Teal',
                                    'Green',
                                    'Light Green',
                                    'Lime',
                                    'Yellow',
                                    'Amber',
                                    'Orange',
                                    'Deep Orange',
                                    'Red',
                                    'Pink',
                                    'White',
                                  ];
                                  return BottomGradientContainer(
                                    borderRadius: BorderRadius.circular(
                                      20.0,
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.all(10),
                                      itemCount: colors.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 15.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              for (int hue in [
                                                100,
                                                200,
                                                400,
                                                700
                                              ])
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      themeColor =
                                                          colors[index];
                                                      colorHue = hue;
                                                      currentTheme.switchColor(
                                                        colors[index],
                                                        colorHue,
                                                      );
                                                      setState(
                                                        () {},
                                                      );
                                                      switchToCustomTheme();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10.0,
                                                        ),
                                                        color:
                                                            MyTheme().getColor(
                                                          colors[index],
                                                          hue,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey[900]!,
                                                            blurRadius: 5.0,
                                                            offset:
                                                                const Offset(
                                                              0.0,
                                                              3.0,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      child: (themeColor ==
                                                                  colors[
                                                                      index] &&
                                                              colorHue == hue)
                                                          ? const Icon(
                                                              Icons
                                                                  .done_rounded,
                                                            )
                                                          : const SizedBox(),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            dense: true,
                          ),
            ],
          ),
        ),
      ),
    );
  }
}
