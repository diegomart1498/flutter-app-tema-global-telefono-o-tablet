import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool? puntosArriba;
  final Color? colorPrimario;
  final Color? colorSecundario;
  final double? bulletPrimario;
  final double? bulletSecundario;

  const Slideshow({
    Key? key,
    required this.slides,
    this.puntosArriba = false,
    this.colorPrimario = Colors.pink,
    this.colorSecundario = Colors.grey,
    this.bulletPrimario = 12.0,
    this.bulletSecundario = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlidershowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (context) {
              //? Espera a que se cree la instancia para ahí sí setearla
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Provider.of<_SlidershowModel>(context, listen: false)
                    .tamanoPuntoP = bulletPrimario!;
                Provider.of<_SlidershowModel>(context, listen: false)
                    .tamanoPuntoS = bulletSecundario!;
              });
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (puntosArriba!)
                    _Dots(slides, colorPrimario!, colorSecundario!),
                  Expanded(
                    child: _Slides(slides),
                  ),
                  if (!puntosArriba!)
                    _Dots(slides, colorPrimario!, colorSecundario!),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SlidershowModel extends ChangeNotifier {
  double _currentPage = 0;
  double _tamanoPuntoP = 12;
  double _tamanoPuntoS = 12;

  double get currentPage => _currentPage;
  set currentPage(double currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }

  double get tamanoPuntoP => _tamanoPuntoP;
  set tamanoPuntoP(double tamano) {
    _tamanoPuntoP = tamano;
    notifyListeners();
  }

  double get tamanoPuntoS => _tamanoPuntoS;
  set tamanoPuntoS(double tamano) {
    _tamanoPuntoS = tamano;
    notifyListeners();
  }
}

//*SLIDES
class _Slides extends StatefulWidget {
  final List<Widget> slides;
  const _Slides(this.slides);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    pageViewController.addListener(() {
      Provider.of<_SlidershowModel>(context, listen: false).currentPage =
          pageViewController.page!;
    });
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageViewController,
      children: widget.slides.map((slide) => _Slide(slide: slide)).toList(),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;
  const _Slide({
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      child: slide, //SvgPicture.asset(svg),
    );
  }
}

//*PUNTOS
class _Dots extends StatelessWidget {
  final List<Widget> slides;
  final Color colorPrimario;
  final Color colorSecundario;
  const _Dots(
    this.slides,
    this.colorPrimario,
    this.colorSecundario,
  );

  @override
  Widget build(BuildContext context) {
    final List<int> puntos = [];
    for (int i = 0; i < slides.length; i++) {
      puntos.add(i);
    }
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //children: List.generate(slide.length, (i) => _Dot(i)),
        children: puntos
            .map((punto) => _Dot(punto, colorPrimario, colorSecundario))
            .toList(),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  final Color colorPrimario;
  final Color colorSecundario;
  const _Dot(
    this.index,
    this.colorPrimario,
    this.colorSecundario,
  );

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SlidershowModel>(context);
    final double tamano = (ssModel._currentPage.round() == index)
        ? ssModel.tamanoPuntoP
        : ssModel.tamanoPuntoS;
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: tamano,
      height: tamano,
      decoration: BoxDecoration(
        color: (ssModel._currentPage.round() == index)
            ? colorPrimario
            : colorSecundario,
        shape: BoxShape.circle,
      ),
      duration: const Duration(milliseconds: 200),
    );
  }
}
