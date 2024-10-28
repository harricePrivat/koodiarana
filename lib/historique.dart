import 'package:flutter/material.dart';

class HistoriqueCustomer extends StatefulWidget {
  const HistoriqueCustomer({super.key});

  @override
  State<HistoriqueCustomer> createState() => _HistoriqueCustomerState();
}

class _HistoriqueCustomerState extends State<HistoriqueCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique de deplacement"),
      ),
      body: const Center(
        child: Text("Pas encore d'historique"),
      ),
    );
  }
}
