import 'dart:math';

import 'package:expenses/models/transactions.dart';
import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/transaction_form.dart';
import 'package:expenses/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = [
    Transactions(
      id: 't1',
      title: 'Tenis de Corrida',
      value: 350.25,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transactions(
      id: 't2',
      title: 'Conta de Luz',
      value: 400,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  // Função para pegar as transações mais recentes
  List<Transactions> get _recentTransaction {
    return _transactions.where((tr) {
      // metodo .isAfter é uma função usada para datas.. Ela retorna apenas dados que tiver dentro da data que foi passada. No exemplo.. Apenas as que foram 7 dias atrás!
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transactions(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    // A variavel newTransaction esta sendo atualizada e depois sendo inserida no lista _transaction
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(onSubmit: _addTransaction,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          actions: [
            IconButton(
              onPressed: () => _openTransactionFormModal(context),
              icon: const Icon(Icons.add),
            ),
          ],
          title: const Text("Despesas Pessoais"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Chart(recentTransaction: _recentTransaction),
              TransactionList(transactions: _transactions),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openTransactionFormModal(context),
          child: const Icon(Icons.add),
        ));
  }
}
