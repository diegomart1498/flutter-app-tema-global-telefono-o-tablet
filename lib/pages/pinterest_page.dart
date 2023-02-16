import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_app/theme/theme_changer.dart';
import 'package:my_app/widgets/pinterest_menu.dart';
import 'package:provider/provider.dart';

class PinterestPage extends StatelessWidget {
  const PinterestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModelo(),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: const [
            _PinterestGrid(),
            _PinterestMenuLocation(),
          ],
        ),
      ),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {
  const _PinterestMenuLocation();

  @override
  Widget build(BuildContext context) {
    final mostrar = Provider.of<_MenuModelo>(context).mostrar;
    final appTheme = Provider.of<ThemeChanger>(context).darkTheme;
    final List<PinterestButton> items = [
      PinterestButton(
          onPressed: () {
            print('pie_chart');
          },
          icon: Icons.pie_chart),
      PinterestButton(
          onPressed: () {
            print('search');
          },
          icon: Icons.search),
      PinterestButton(
          onPressed: () {
            print('notifications');
          },
          icon: Icons.notifications),
      PinterestButton(
          onPressed: () {
            print('supervised_user_circle');
          },
          icon: Icons.supervised_user_circle),
    ];
    return Positioned(
        bottom: 30,
        child: PinterestMenu(
          backgroundColor: (appTheme) ? Colors.grey : Colors.white,
          mostrar: mostrar,
          items: items,
        ));
  }
}

class _PinterestGrid extends StatefulWidget {
  const _PinterestGrid();

  @override
  State<_PinterestGrid> createState() => _PinterestGridState();
}

class _PinterestGridState extends State<_PinterestGrid> {
  ScrollController controller = ScrollController();
  double scrollAnterior = 0;

  @override
  void initState() {
    controller.addListener(() {
      // print('Scroll Listener: ${controller.offset}');
      if (controller.offset > scrollAnterior) {
        Provider.of<_MenuModelo>(context, listen: false).mostrar = false;
        // print(Provider.of<_MenuModelo>(context, listen: false).mostrar);
      } else {
        Provider.of<_MenuModelo>(context, listen: false).mostrar = true;
        // print(Provider.of<_MenuModelo>(context, listen: false).mostrar);
      }
      scrollAnterior = controller.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<int> items = List.generate(101, (index) => index);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: StaggeredGridView.countBuilder(
        controller: controller,
        crossAxisCount: 4,
        itemCount: items.length,
        itemBuilder: (context, index) => _PinterestItem(index),
        staggeredTileBuilder: (index) =>
            StaggeredTile.count(2, index.isEven ? 2 : 3),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;
  const _PinterestItem(this.index);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: Colors.blue,
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text('$index'),
          ),
        ),
      ),
    );
  }
}

//
class _MenuModelo extends ChangeNotifier {
  bool _mostrar = true;
  bool get mostrar => _mostrar;
  set mostrar(bool valor) {
    _mostrar = valor;
    notifyListeners();
  }
}
