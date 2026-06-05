import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

class SignedInWelcomePopup extends StatelessWidget {
  const SignedInWelcomePopup({super.key});

  static void show() {
    fsdui.showOverlay(
      calloutConfig: CalloutConfig(
        cId: 'signed-in-welcome',
        initialCalloutW: 660,
        initialCalloutH: 300,
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
        child: SignedInWelcomePopup(),
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
        height: 300,
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
                      TextSpan(
                        text: 'Welcome\n\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),
                      ),
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
          ],
        ),
      ),
    ),
  );
}
