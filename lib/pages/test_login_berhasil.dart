import 'package:flutter/material.dart';

class TestLoginBerhasil extends StatefulWidget {
  final String username;
  const TestLoginBerhasil({
    super.key,
    required this.username,
  });

  @override
  State<TestLoginBerhasil> createState() => _TestLoginBerhasilState();
}

class _TestLoginBerhasilState extends State<TestLoginBerhasil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berhasil Login, Halo ${widget.username}'),
      ),
    );
  }
}
