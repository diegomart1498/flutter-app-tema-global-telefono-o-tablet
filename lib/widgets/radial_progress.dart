import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final double porcentaje;
  final Color? colorPrimario;
  final Color? colorSecundario;
  final double? grosorPrimario;
  final double? grosorSecundario;

  const RadialProgress({
    super.key,
    required this.porcentaje,
    this.colorPrimario = Colors.blue,
    this.colorSecundario = Colors.grey,
    this.grosorPrimario = 10.0,
    this.grosorSecundario = 5.0,
  });

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  //*
  late AnimationController controller;
  late double porcentajeAnterior;
  @override
  void initState() {
    porcentajeAnterior = widget.porcentaje;
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _MiRadialProgress(
              porcentaje: (widget.porcentaje - diferenciaAnimar) +
                  (diferenciaAnimar * controller.value),
              colorPrimario: widget.colorPrimario!,
              colorSecundario: widget.colorSecundario!,
              grosorPrimario: widget.grosorPrimario!,
              grosorSecundario: widget.grosorSecundario!,
            ),
          ),
        );
      },
    );
  }
}

class _MiRadialProgress extends CustomPainter {
  final double porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorPrimario;
  final double grosorSecundario;

  _MiRadialProgress({
    required this.porcentaje,
    required this.colorPrimario,
    required this.colorSecundario,
    required this.grosorPrimario,
    required this.grosorSecundario,
  });
  @override
  void paint(Canvas canvas, Size size) {
    //*Gradiente
    const Gradient grandiente = LinearGradient(colors: [
      Color(0xffC012FF),
      Color(0xff6D05E8),
      Colors.red,
    ]);
    final Rect rect = Rect.fromCircle(center: const Offset(0, 0), radius: 180);
    //*Círculo
    final paint = Paint()
      ..strokeWidth = grosorSecundario
      ..color = colorSecundario
      ..style = PaintingStyle.stroke;
    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radio = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radio, paint);

    //*Arco
    final paintArc = Paint()
      ..strokeWidth = grosorPrimario
      // ..color = colorPrimario
      ..shader = grandiente.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    double arcAngle = 2 * pi * (porcentaje / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radio),
      -pi / 2,
      arcAngle,
      false,
      paintArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
