import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_app/main.dart';
import 'package:my_app/models/layout_model.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class CuadradoAnimadoPage extends StatelessWidget {
  const CuadradoAnimadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        final layout = Provider.of<LayoutModel>(context);
        if (orientation == Orientation.landscape && !layout.landscape) {
          layout.landscape = true;
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ),
              );
            },
          );
          // return Container();
        }
        return const Scaffold(
          body: Center(
            child: CuadradoAnimado(),
          ),
        );
      },
    );
  }
}

class CuadradoAnimado extends StatefulWidget {
  const CuadradoAnimado({
    super.key,
  });

  @override
  State<CuadradoAnimado> createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado>
    with SingleTickerProviderStateMixin {
  //
  late AnimationController controller;
  late Animation<double> moverDerecha;
  late Animation<double> moverIzquierda;
  late Animation<double> moverArriba;
  late Animation<double> moverAbajo;
  late Animation<double> rotacion;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    moverDerecha = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.25, curve: Curves.bounceOut),
    ));
    moverArriba = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.25, 0.5, curve: Curves.bounceOut),
    ));
    moverIzquierda = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 0.75, curve: Curves.bounceOut),
    ));
    moverAbajo = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.75, 1.0, curve: Curves.bounceOut),
    ));
    rotacion = Tween(begin: 0.0, end: 4 * math.pi).animate(controller);

    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        controller.reset();
      }
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
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      child: const _Rectangulo(),
      builder: (BuildContext context, Widget? childRectangle) {
        return Transform.translate(
          offset: Offset(
            moverDerecha.value - moverIzquierda.value,
            -moverArriba.value + moverAbajo.value,
          ),
          child: Transform.rotate(
            angle: rotacion.value,
            child: childRectangle,
          ),
        );
      },
    );
  }
}

class _Rectangulo extends StatelessWidget {
  const _Rectangulo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      color: Colors.blue,
      // child: const Icon(
      //   Icons.star,
      //   color: Colors.yellow,
      //   size: 70,
      // ),
    );
  }
}
