import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_app/main.dart';
import 'package:my_app/models/layout_model.dart';
import 'package:my_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HeadersPage extends StatelessWidget {
  const HeadersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        final layout = Provider.of<LayoutModel>(context);
        if (orientation == Orientation.landscape && !layout.landscape) {
          layout.landscape = true;
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MyApp(),
              ),
            );
          });
          // return Container();
        }
        return const Scaffold(
          body: HeaderWaveGradient(),
        );
      },
    );
  }
}
