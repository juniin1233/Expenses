import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({ super.key, required this.transactions});

  final List transactions;

   @override
   Widget build(BuildContext context) {
       return Container(
            height: 300,
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, i){
                final e = transactions[i];
              return Card(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.purple,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        /*
                        
                          Esse metodo *.toStringAsFixed()* Recebe um valor int.
                          Funciona quantos casas decimais estaram no número

                        */
                        'R\$ ${e.value.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.purple),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          // e.date.toString(),
                          // Melhor jeito de formatar data
                          // h = hora em 12h e H = hora em 24h
                          // m = minutos e M = Mês
                          // d = dia do mês e D = dia do ano
                          // E = Dia da Semana

                          DateFormat('dd MMMM y').format(e.date),
                          // e.date.toString(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              );
            })
          );
  }
}