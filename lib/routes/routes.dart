import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/challenges/cuadrado_animado_page.dart';
import 'package:my_app/pages/pages.dart';

final List<Route> pageRoutes = [
  Route(FontAwesomeIcons.slideshare, 'Slideshow', const SlideshowPage()),
  Route(FontAwesomeIcons.heading, 'Headers', const HeadersPage()),
  Route(FontAwesomeIcons.peopleCarryBox, 'Animated Box',
      const CuadradoAnimadoPage()),
  Route(FontAwesomeIcons.circleNotch, 'Progress Bars',
      const GraficasCircularesPage()),
  Route(FontAwesomeIcons.pinterest, 'Pinterest', const PinterestPage()),
];

class Route {
  final IconData icon;
  final String titulo;
  final Widget page;

  Route(
    this.icon,
    this.titulo,
    this.page,
  );
}
