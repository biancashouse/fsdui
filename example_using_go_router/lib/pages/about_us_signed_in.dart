import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

class AboutUsSignedIn extends StatefulWidget {
  const AboutUsSignedIn({super.key});

  static void show() {
    fsdui.showOverlay(
      calloutConfig: CalloutConfig(
        cId: 'about-us',
        initialCalloutW: 660,
        initialCalloutH: 560,
        decorationBorderRadius: 16,
        decorationFillColors: ColorOrGradient.color(Colors.black),
        // showCloseButton: true,
        barrier: CalloutBarrierConfig(
          opacity: 0.5,
          onTappedF: () async {
            fsdui.dismiss("about-us");
          },
        ),
      ),
      calloutContent: const Padding(
        padding: EdgeInsets.all(18.0),
        child: const AboutUsSignedIn(),
      ),
      // calloutContent: Padding(
      //   padding: EdgeInsets.all(18.0),
      //   child: Container(
      //     width: 660, height: 560, color: Colors.blue,
      //   ),
      // ),
    );
  }

  @override
  State<AboutUsSignedIn> createState() => _AboutUsSignedInState();
}

class _AboutUsSignedInState extends State<AboutUsSignedIn> {
  final _feedbackTeC = TextEditingController();

  // bool _saving = false;

  @override
  void dispose() {
    _feedbackTeC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<CAPIBloC, CAPIState>(
    buildWhen: (prev, next) =>
        prev.appRating != next.appRating || prev.ea != next.ea,
    builder: (context, state) => Material(
      child: SizedBox(
        width: 660,
        height: 560,
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
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 300,
                height: 260,
                padding: const EdgeInsets.all(18),
                color: Colors.grey[900],
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'This app is free forever — a rating is always appreciated!',
                      style: TextStyle(color: Colors.white70, fontSize: 20),
                    ),
                    const Gap(20),
                    Opacity(
                      opacity: state.isNotSignedIn() ? 0.2 : 1.0,
                      child: _starsRow(rating: state.appRating),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 340,
                height: 260,
                color: Colors.grey[900],
                child: state.ea == null
                    ? _signInPrompt()
                    : _feedbackForm(state),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // Widget build2(BuildContext context) => Row(
  //   children: <Widget>[
  //     Column(
  //       mainAxisSize: MainAxisSize.max,
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         const Image(
  //           image: AssetImage('assets/images/ian-with-cpals.png'),
  //           width: 300,
  //           height: 250,
  //         ),
  //         const Expanded(
  //           child: Center(
  //             child: Text(
  //               'Created by Ian White, a trainer at Computer Pals in Narrabeen, and AvPals in Avalon beach, NSW.\n\n'
  //               'This app is free forever — a rating is always appreciated!',
  //               style: TextStyle(color: Colors.white70, height: 1.6),
  //             ),
  //           ),
  //         ),
  //         _starsRow(interactive: false),
  //         const Expanded(
  //           child: Text(
  //             'Thanks for your rating!',
  //             style: TextStyle(color: Colors.white54, fontSize: 12),
  //           ),
  //         ),
  //         // const SizedBox(height: 16),
  //       ],
  //     ),
  //     Column(
  //       mainAxisSize: MainAxisSize.max,
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         const Center(
  //           child: Text(
  //             'Created by Ian White, a trainer at Computer Pals in Narrabeen, and AvPals in Avalon beach, NSW.',
  //             style: TextStyle(color: Colors.white70, height: 1.6),
  //           ),
  //         ),
  //         SizedBox(
  //           width: 240,
  //           child: TextField(
  //             controller: _emailTeC,
  //             onChanged: (_) => setState(() {}),
  //             style: const TextStyle(color: Colors.white70, fontSize: 13),
  //             decoration: InputDecoration(
  //               hintText: 'your@email.com',
  //               hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
  //               errorText:
  //                   _emailTeC.text.isNotEmpty &&
  //                       !_validEmail(_emailTeC.text.trim())
  //                   ? 'Enter a valid email'
  //                   : null,
  //               errorStyle: const TextStyle(fontSize: 11),
  //               contentPadding: const EdgeInsets.symmetric(
  //                 horizontal: 10,
  //                 vertical: 8,
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //                 borderSide: const BorderSide(color: Colors.white24),
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //                 borderSide: const BorderSide(color: Colors.white54),
  //               ),
  //               errorBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //                 borderSide: const BorderSide(color: Colors.redAccent),
  //               ),
  //               focusedErrorBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //                 borderSide: const BorderSide(color: Colors.redAccent),
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           width: 240,
  //           child: TextField(
  //             controller: _feedbackTeC,
  //             maxLines: 3,
  //             style: const TextStyle(color: Colors.white70, fontSize: 13),
  //             decoration: InputDecoration(
  //               hintText: 'Any feedback? (optional)',
  //               hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
  //               contentPadding: const EdgeInsets.symmetric(
  //                 horizontal: 10,
  //                 vertical: 8,
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //                 borderSide: const BorderSide(color: Colors.white24),
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //                 borderSide: const BorderSide(color: Colors.white54),
  //               ),
  //             ),
  //           ),
  //         ),
  //         ElevatedButton(
  //           onPressed:
  //               (_rating != null &&
  //                   _validEmail(_emailTeC.text.trim()) &&
  //                   !_saving)
  //               ? _submit
  //               : null,
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: const Color(0xFF4285F4),
  //             foregroundColor: Colors.white,
  //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //           ),
  //           child: _saving
  //               ? const SizedBox(
  //                   width: 14,
  //                   height: 14,
  //                   child: CircularProgressIndicator(
  //                     strokeWidth: 2,
  //                     color: Colors.white,
  //                   ),
  //                 )
  //               : const Text('Submit', style: TextStyle(fontSize: 13)),
  //         ),
  //       ],
  //     ),
  //   ],
  // );

  Widget _signInPrompt() {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'Sign in to rate & send feedback, and to keep your game and puzzle progress and history — handy for tracking how you\'re improving over time.',
            style: TextStyle(
              color: Color.fromARGB(179, 235, 150, 59),
              height: 1.5,
              fontSize: 16,
            ),
          ),
          FilledButton(
            onPressed: () {
              if (fsdui.gcrServerUrl != null) {
                fsdui.showPasswordlessSignIn();
              }
              fsdui.dismiss('about-us');
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Sign in',
              style: TextStyle(fontSize: 13, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _feedbackForm(CAPIState state) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Enjoying the app ? Suggestions ?\nSend us a Message...',
            style: TextStyle(
              color: Colors.white70,
              height: 1.6,
              fontSize: 16.0,
            ),
          ),
        ),
        SizedBox(
          width: 240,
          child: TextField(
            controller: _feedbackTeC,
            maxLines: 6,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Any feedback? (optional)',
              hintStyle: const TextStyle(color: Colors.white54, fontSize: 13),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.yellow),
              ),
            ),
          ),
        ),
        FilledButton(
          onPressed: () {
            fsdui.capiBloc.add(SaveFeedback(_feedbackTeC.text));
            fsdui.dismiss('about-us');
          },
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 13, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _starsRow({required int? rating}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = rating != null && i < rating;
        final icon = Icon(
          filled ? Icons.star_rounded : Icons.star_outline_rounded,
          color: const Color(0xFFFFCC00),
          size: 30,
        );
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => fsdui.capiBloc.add(UpdateAppRating(i + 1)),
            child: icon,
          ),
        );
      }),
    );
  }
}
