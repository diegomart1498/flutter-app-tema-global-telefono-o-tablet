import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  final Function() onPressed;
  final IconData icon;
  PinterestButton({
    required this.onPressed,
    required this.icon,
  });
}

class PinterestMenu extends StatelessWidget {
  final List<PinterestButton> items;
  final bool mostrar;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  const PinterestMenu({
    Key? key,
    required this.items,
    this.mostrar = true,
    this.backgroundColor = Colors.white,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.black54,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: (mostrar) ? 1 : 0,
        child: Container(
          width: 250,
          height: 60,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black38,
                  offset: Offset(5, 5),
                  blurRadius: 10,
                  spreadRadius: -4)
            ],
          ),
          child: Builder(builder: (context) {
            Provider.of<_MenuModel>(context).mostrarFuncion = mostrar;
            return _MenuItems(items, activeColor, inactiveColor);
          }),
        ),
      ),
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestButton> menuItems;
  final Color activeColor;
  final Color inactiveColor;

  const _MenuItems(
    this.menuItems,
    this.activeColor,
    this.inactiveColor,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        menuItems.length,
        (i) => _PinterestMenuItem(
          index: i,
          button: menuItems[i],
          activeColor: activeColor,
          inactiveColor: inactiveColor,
        ),
      ),
    );
  }
}

class _PinterestMenuItem extends StatelessWidget {
  final int index;
  final PinterestButton button;
  final Color activeColor;
  final Color inactiveColor;

  const _PinterestMenuItem({
    required this.index,
    required this.button,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final itemModel = Provider.of<_MenuModel>(context);
    return IconButton(
      icon: Icon(
        button.icon,
        size: (itemModel.itemSeleccionado == index) ? 34 : 30,
        color:
            (itemModel.itemSeleccionado == index) ? activeColor : inactiveColor,
      ),
      onPressed: (itemModel.mostrarFuncion)
          ? () {
              button.onPressed();
              itemModel.itemSeleccionado = index;
            }
          : null,
    );
  }
}

class _MenuModel extends ChangeNotifier {
  bool mostrarFuncion = true;
  int _itemSeleccionado = 0;
  int get itemSeleccionado => _itemSeleccionado;
  set itemSeleccionado(int index) {
    _itemSeleccionado = index;
    notifyListeners();
  }
}
