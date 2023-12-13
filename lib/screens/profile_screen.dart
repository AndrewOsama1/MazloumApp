import 'package:flutter/material.dart';
import 'package:mazloum_app/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
               /* SliverAppBar(
                  expandedHeight: 50,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    titlePadding: EdgeInsets.symmetric(horizontal: 16),
                    title: Text(
                      'Settings',
                      style: theme.textTheme.headline6,
                    ),
                  ),
                ),*/
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text("Account", style: theme.textTheme.headline6?.copyWith(fontWeight: FontWeight.w400)),
                      SizedBox(height: 16),
                      _buildListTile('Login / Register', Icons.supervisor_account_rounded, '', Colors.grey, theme, onTab: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      }),
                      const SizedBox(height: 32),
                      Text("Settings", style: theme.textTheme.headline6?.copyWith(fontWeight: FontWeight.w400)),
                      const SizedBox(height: 16),

                        _buildListTile('Appearance', Icons.dark_mode, "Theme", Colors.purple, theme, onTab: () {}),
                      const SizedBox(height: 8),
                      _buildListTile('Language', Icons.language, 'English', Colors.orange, theme, onTab: () {}),
                      const SizedBox(height: 8),
                   /*   _buildListTile('Notifications', Icons.notifications_outlined, '', Colors.blue, theme, onTab: () {}),
                      const SizedBox(height: 8),*/
                      _buildListTile('Help', Icons.help, '', Colors.green, theme, onTab: () {}),
                      const SizedBox(height: 8),
                      _buildListTile('Logout', Icons.exit_to_app, '', Colors.red, theme, onTab: () {}),
                    ],
                  ),
                ],
              ),
            )
        )
    );
  }

  Widget _buildListTile(String title, IconData icon, String trailing, Color color, theme, {onTab}) {
    return ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withAlpha(30)
          ),
          child: Center(
            child: Icon(icon, color: color,),
          ),
        ),
        title: Text(title, style: theme.textTheme.subtitle1),
        trailing: SizedBox(
          width: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(trailing, style: theme.textTheme.bodyText1?.copyWith(color: Colors.grey.shade600)),
              const Icon(Icons.arrow_forward_ios, size: 16,),
            ],
          ),
        ),
        onTap: onTab
    );
  }

  _showAppearanceModal(ThemeData theme, String current,BuildContext context) {
   showModalBottomSheet(context: context,
        builder: (context) =>
        Container(
          padding: const EdgeInsets.all(16),
          height: 320,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select a Theme", style: theme.textTheme.subtitle1,),
              const SizedBox(height: 32),
              ListTile(
                leading: const Icon(Icons.brightness_5, color: Colors.blue,),
                title: Text("Light", style: theme.textTheme.bodyText1),
                onTap: () {
                  //_themesController.setTheme('light');
                  Navigator.pop(context);
                },
                trailing: Icon(Icons.check, color: current == 'light' ? Colors.blue : Colors.transparent,),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.brightness_2, color: Colors.orange,),
                title: Text("Dark", style: theme.textTheme.bodyText1),
                onTap: () {
                  //_themesController.setTheme('dark');
                 Navigator.pop(context);
                },
                trailing: Icon(Icons.check, color: current == 'dark' ? Colors.orange : Colors.transparent,),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.brightness_6, color: Colors.blueGrey,),
                title: Text("System", style: theme.textTheme.bodyText1),
                onTap: () {
                //  _themesController.setTheme('system');
                  Navigator.pop(context);
                },
                trailing: Icon(Icons.check, color: current == 'system' ? Colors.blueGrey : Colors.transparent,),
              ),
            ],
          ),
        )
    );
  }
}