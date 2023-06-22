import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petdopter/presentation/landing_module/bloc/auth_bloc.dart';
import 'package:petdopter/presentation/presentation.dart';

class AdoptionHistoryScreenWrapper extends StatelessWidget {
  const AdoptionHistoryScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const LandingPage(),
    );
  }
}
