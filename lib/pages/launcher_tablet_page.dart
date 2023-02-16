import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/models/layout_model.dart';
import 'package:provider/provider.dart';
import 'package:my_app/routes/routes.dart';
import 'package:my_app/theme/theme_changer.dart';

class LauncherTabletPage extends StatelessWidget {
  const LauncherTabletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final accentColor = appTheme.currentTheme.colorScheme.secondary;
    final layout = Provider.of<LayoutModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diseños en Flutter - Landscape'),
        centerTitle: true,
      ),
      drawer: const _MenuPrincipal(),
      body: Row(
        children: [
          const SizedBox(
            width: 320,
            height: double.infinity,
            child: _ListaOpciones(),
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: (appTheme.darkTheme) ? Colors.grey : accentColor,
          ),
          Expanded(child: layout.currentPage),
        ],
      ),
      // body: const _ListaOpciones(),
    );
  }
}

class _MenuPrincipal extends StatelessWidget {
  const _MenuPrincipal();

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final accentColor = appTheme.currentTheme.colorScheme.secondary;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 120,
              child: CircleAvatar(
                backgroundColor: accentColor,
                child: const Text('DM', style: TextStyle(fontSize: 40)),
              ),
            ),
            // const Divider(),
            const Expanded(child: _ListaOpciones()),
            ListTile(
              title: const Text('Dark Mode'),
              leading: Icon(Icons.lightbulb_outline, color: accentColor),
              trailing: Switch.adaptive(
                value: appTheme.darkTheme,
                activeColor: accentColor,
                onChanged: (value) {
                  appTheme.darkTheme = value;
                },
              ),
            ),
            ListTile(
              title: const Text('Custom Theme'),
              leading: Icon(Icons.add_to_home_screen, color: accentColor),
              trailing: Switch.adaptive(
                value: appTheme.customTheme,
                activeColor: accentColor,
                onChanged: (value) {
                  appTheme.customTheme = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListaOpciones extends StatelessWidget {
  const _ListaOpciones();

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    final layout = Provider.of<LayoutModel>(context);
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Divider(
        color: appTheme.primaryColorLight,
      ),
      itemCount: pageRoutes.length,
      itemBuilder: (context, index) => ListTile(
        leading: FaIcon(pageRoutes[index].icon,
            color: appTheme.colorScheme.secondary),
        title: Text(pageRoutes[index].titulo),
        trailing:
            Icon(Icons.chevron_right, color: appTheme.colorScheme.secondary),
        onTap: () {
          layout.currentPage = pageRoutes[index].page;
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => pageRoutes[index].page,
          //   ),
          // );
        },
      ),
    );
  }
}
