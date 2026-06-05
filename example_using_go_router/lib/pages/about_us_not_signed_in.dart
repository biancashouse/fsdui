import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

class AboutUsNotSignedIn extends StatelessWidget {
  const AboutUsNotSignedIn({super.key});

  static void show() {
    fsdui.showOverlay(
      calloutConfig: CalloutConfig(
        cId: 'signed-in-welcome',
        initialCalloutW: 660,
        initialCalloutH: 430,
        decorationBorderRadius: 16,
        decorationFillColors: ColorOrGradient.color(Colors.black),
        // showCloseButton: true,
        barrier: CalloutBarrierConfig(
          opacity: 0.5,
          onTappedF: () {
            fsdui.dismiss("signed-in-welcome");
          },
        ),
      ),
      calloutContent: const Padding(
        padding: EdgeInsets.all(18.0),
        child: AboutUsNotSignedIn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<CAPIBloC, CAPIState>(
    buildWhen: (prev, next) =>
        prev.appRating != next.appRating || prev.ea != next.ea,
    builder: (context, state) => Material(
      child: SizedBox(
        width: 660,
        height: 430,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 380,
                height: 280,
                color: Colors.black,
                child: const Image(
                  image: AssetImage('assets/images/ian-with-cpals.png'),
                  // width: 260,
                  height: 250,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 260,
                height: 280,
                padding: const EdgeInsets.all(18),
                color: Colors.black,
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                    children: [
                      TextSpan(text: 'Created by the trainers at '),
                      TextSpan(
                        text: 'Computer Pals',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' in Narrabeen, and '),
                      TextSpan(
                        text: 'AvPals',
                        style: TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' in Avalon beach, NSW.'),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 660,
                height: 130,
                color: Colors.grey[900],
                child: const Text(
                  "\nYou're not signed in: why sign in ?\n"
                  "(1) You can do your crosswords and puzzles across all your devices.\n"
                  "(2) You can share your crosswords and puzzles with other users.\n"
                  "(3) You can provide a rating and feedback about this app.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
