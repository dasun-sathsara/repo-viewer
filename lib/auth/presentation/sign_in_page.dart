import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(MdiIcons.github, size: 150),
              Text(
                'Welcome to\n Repo Viewser',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(fontSize: 42, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size.fromHeight(40)),
                child: Text(
                  'Sign In',
                  style: GoogleFonts.roboto(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
