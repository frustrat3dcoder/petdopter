import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petdopter/data/data.dart';
import 'package:petdopter/domain/entities/user_entity.dart';
import 'package:petdopter/presentation/landing_module/bloc/auth_bloc.dart';

class ProfileScreenWrapper extends StatelessWidget {
  const ProfileScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final HiveService hiveService = di<HiveService>();
  late UserEntity userEntity;

  @override
  void initState() {
    initDataFromLocal();
    super.initState();
  }

  void initDataFromLocal() async {
    final userMap = hiveService.retrieveValue('userEntity');

    setState(() {
      userEntity = UserEntity.fromJson(jsonDecode(userMap));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
