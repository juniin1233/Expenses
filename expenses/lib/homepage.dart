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
  final _transactions = <Transactions>[
    Transactions(
      id: '1',
      title: 'Conta de Luz',
      value: 320.00,
      date: DateTime.now(),
    ),
    Transactions(
      id: '2',
      title: 'Conta de Agua',
      value: 50.25,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transactions(
      id: '3',
      title: 'Fatura do Cartão',
      value: 1500.00,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transactions(
      id: '4',
      title: 'Fatura Vivo',
      value: 33.30,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transactions(
      id: '5',
      title: 'Lanche',
      value: 20.00,
      date: DateTime.now(),
    ),
    Transactions(
      id: '6',
      title: 'Lazer',
      value: 320.00,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
  ];

  // Função para pegar as transações mais recentes
  List<Transactions> get _recentTransaction {
    return _transactions.where((tr) {
      // metodo .isAfter é uma função usada para datas.. Ela retorna apenas dados que tiver dentro da data que foi passada. No exemplo.. Apenas as que foram 7 dias atrás!
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transactions(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    // A variavel newTransaction esta sendo atualizada e depois sendo inserida no lista _transaction
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
          onSubmit: _addTransaction,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: const Icon(Icons.add),
          ),
        ],
        title: const Text("Despesas Pessoais"),
      );

    final availableHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: availableHeight * 0.25,
              child: Chart(
                recentTransaction: _recentTransaction,
              ),
            ),
            SizedBox(
              height: availableHeight * 0.75,
              child: TransactionList(
                transactions: _transactions,
                onRemove: _removeTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
