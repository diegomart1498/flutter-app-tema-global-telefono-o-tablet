import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/theme/theme_changer.dart';
import 'package:my_app/widgets/slideshow.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLarge;
    if (MediaQuery.of(context).size.width > 500) {
      isLarge = true;
    } else {
      isLarge = false;
    }
    List<Widget> children = [
      SizedBox(
        height: (isLarge) ? 350 : 400,
        width: double.infinity,
        child: const MiSlideShow(),
      ),
      SizedBox(
        height: (isLarge) ? 350 : 400,
        width: double.infinity,
        child: const MiSlideShow(),
      ),
      SizedBox(
        height: (isLarge) ? 350 : 400,
        width: double.infinity,
        child: const MiSlideShow(),
      ),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: children),
      ),
    );
  }
}

class MiSlideShow extends StatelessWidget {
  const MiSlideShow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final accentColor = appTheme.currentTheme.colorScheme.secondary;
    return Slideshow(
      bulletPrimario: 15,
      colorPrimario:
          (appTheme.darkTheme) ? accentColor : const Color(0xffFF5A7E),
      slides: [
        SvgPicture.asset('assets/slide-1.svg'),
        SvgPicture.asset('assets/slide-2.svg'),
        SvgPicture.asset('assets/slide-3.svg'),
        SvgPicture.asset('assets/slide-4.svg'),
        SvgPicture.asset('assets/slide-5.svg'),
        SvgPicture.asset('assets/slide-6.svg'),
      ],
    );
  }
}
