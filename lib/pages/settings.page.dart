import 'package:daily_recipe/pages/profile.page.dart';
import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';
import '../provider/local.model.provider.dart';
import '../widgets/header.bar.dart';
import 'notification.page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SideMenuPage(),
                    ));
              },
              icon: const Icon(Icons.sort)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationPage(),
                      ));
                },
                icon: const Icon(Icons.notifications)),
          ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderBar(title: "Settings".tr(), titleRight: ""),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: const Icon(Icons.language_sharp),
                  title: const Text("Language").tr(),
                  trailing: InkWell(
                      onTap: () {
                        Dialogs.materialDialog(
                            msg: 'Select your favorites language'.tr(),
                            title: "Set language".tr(),
                            color: Colors.white,
                            context: context,
                            actions: [
                              IconsOutlineButton(
                                onPressed: () {
                                  Provider.of<LocaleLanguage>(context,
                                          listen: false)
                                      .setLocale(
                                          const Locale('ar', 'EG'), context);
                                  Navigator.pop(context);
                                },
                                text: 'Arabic'.tr(),
                                textStyle: const TextStyle(color: Colors.grey),
                                iconColor: Colors.grey,
                              ),
                              IconsButton(
                                onPressed: () {
                                  Provider.of<LocaleLanguage>(context,
                                          listen: false)
                                      .setLocale(
                                          const Locale('en', 'US'), context);
                                  Navigator.pop(context);
                                },
                                text: 'English'.tr(),
                                color: Colors.red,
                                textStyle: const TextStyle(color: Colors.white),
                                iconColor: Colors.white,
                              ),
                            ]);
                      },
                      child: const Text(
                        "Set language",
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 14),
                      ).tr()),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade100, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Divider(),
              ),
              HeaderBar(title: "Profile".tr(), titleRight: ""),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  NavigationUtils.push(
                      context: context, page: const ProfilePage());
                },
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: InkWell(
                      onTap: () {
                        NavigationUtils.push(
                            context: context, page: const ProfilePage());
                      },
                      child: const Text("Edit Profile").tr()),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade100, width: 2),
                    borderRadius: BorderRadius.circular(15),
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
