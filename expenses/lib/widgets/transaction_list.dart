import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required this.transactions, required this.onRemove});

  final List transactions;
  final void Function(String) onRemove;


  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
          builder: (context, constraints){
          return  Column(
              children: [
                const Text(
                  "Nenhuma Transação Cadastrada",
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'asset/img/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          }
        )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, i) {
              final tr = transactions[i];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text(
                          'R\$${tr.value.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  subtitle: Text(DateFormat('dd MMM y').format(tr.date)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onRemove(tr.id),
                    color: Colors.red,
                  ),
                ),
              );
            },
          );
  }
}


/*
                  
                Card(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.purple,
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                        /*
                        
                          Esse metodo *.toStringAsFixed()* Recebe um valor int.
                          Funciona quantos casas decimais estaram no número

                        */
                          'R\$ ${tr.value.toStringAsFixed(2)}',
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
                            tr.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            // tr.date.toString(),
                            // Melhor jeito de formatar data
                            // h = hora em 12h e H = hora em 24h
                            // m = minutos e M = Mês
                            // d = dia do mês e D = dia do ano
                            // E = Dia da Semana

                            DateFormat('dd MMMM y').format(tr.date),
                            // e.date.toString(),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                );
*/
