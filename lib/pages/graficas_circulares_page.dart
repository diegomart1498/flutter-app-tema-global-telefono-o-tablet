import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/theme/theme_changer.dart';
import 'package:my_app/widgets/radial_progress.dart';

class GraficasCircularesPage extends StatefulWidget {
  const GraficasCircularesPage({super.key});

  @override
  State<GraficasCircularesPage> createState() => _GraficasCircularesPageState();
}

class _GraficasCircularesPageState extends State<GraficasCircularesPage> {
  double porcentaje = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              porcentaje += 10;
              if (porcentaje > 100) {
                porcentaje = 0;
              }
            });
          },
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomRadialProgress(
                      porcentaje: porcentaje, color: Colors.yellow),
                  CustomRadialProgress(
                      porcentaje: porcentaje, color: Colors.green),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomRadialProgress(
                      porcentaje: porcentaje, color: Colors.purple),
                  CustomRadialProgress(
                      porcentaje: porcentaje, color: Colors.indigo),
                ],
              ),
            ],
          ),
        ));
  }
}

class CustomRadialProgress extends StatelessWidget {
  const CustomRadialProgress({
    super.key,
    required this.porcentaje,
    required this.color,
  });

  final double porcentaje;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    return Center(
      child: SizedBox(
        height: 150,
        width: 150,
        child: RadialProgress(
          porcentaje: porcentaje,
          colorPrimario: color,
          colorSecundario:
              (appTheme.darkTheme) ? Colors.white60 : Colors.black26,
          grosorPrimario: 10,
          grosorSecundario: 5,
        ),
      ),
    );
  }
}
