import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petdopter/presentation/landing_module/bloc/auth_bloc.dart';

class AdoptionHistoryScreenWrapper extends StatelessWidget {
  const AdoptionHistoryScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const AdoptionHistoryScreen(),
    );
  }
}

class AdoptionHistoryScreen extends StatelessWidget {
  const AdoptionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
