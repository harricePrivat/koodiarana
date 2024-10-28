import 'package:flutter/material.dart';
import 'package:koodiarana/Provider.dart';
import 'package:koodiarana/delayed_animation.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FirstLoginWork extends StatefulWidget {
  const FirstLoginWork({super.key});

  @override
  State<FirstLoginWork> createState() => _FirstLoginWork();
}

class _FirstLoginWork extends State<FirstLoginWork> {
  final controller = PageController();
  // final Color rwColor = const Color(Colors.white);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: DelayedAnimation(
            delay: 200,
            child: Text(
              'Koodiarana Tips',
              style: TextStyle(color: color),
            ),
          )),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: buildPages()),
            buildIndicator(color),
            buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DelayedAnimation(
          delay: 1300,
          child: MaterialButton(
            child: const Text('Suivant'),
            onPressed: () {
              Provider.of<ManageLogin>(context, listen: false).tipsDoneWork();
            },
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildPages() {
    return PageView(
      controller: controller,
      children: [
        onboardPageView(const AssetImage('assets/Logo_koodiarana.png'),
            'Je suis votre employer'),
        onboardPageView(
          const AssetImage('assets/Logo_koodiarana.png'),
          'Cook with step by step instructions!',
        ),
        onboardPageView(
          const AssetImage('assets/Logo_koodiarana.png'),
          'Keep track of what you need to buy',
        ),
      ],
    );
  }

  Widget onboardPageView(ImageProvider imageProvider, String text) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: DelayedAnimation(
            delay: 500,
            child: Image(
              fit: BoxFit.fitWidth,
              image: imageProvider,
            ),
          )),
          const SizedBox(height: 16),
          DelayedAnimation(
            delay: 1000,
            child: Text(
              text,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildIndicator(Color color) {
    return DelayedAnimation(
        delay: 1300,
        child: SmoothPageIndicator(
          controller: controller,
          count: 3,
          effect: WormEffect(
            activeDotColor: color,
          ),
        ));
  }
}
