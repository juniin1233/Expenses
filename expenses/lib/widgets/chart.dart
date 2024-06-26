import 'package:expenses/models/transactions.dart';
import 'package:expenses/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransaction});

  final List<Transactions> recentTransaction;

  // Função criada para agrupar as transições feitas
  // Essa função retorna uma lista do tipo Map
  List<Map<String, Object>> get grouepTransactions {
    return List.generate(7, (index) {
      // Variavel para pegar os ultimos 7 dias
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      // Varendo a lista de transações, para ver se as transações foram feitas nos ultimos 7 dias
      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      // Retornando um map, com a primeira letra do dia da semana e com o valor acumulado daquele dia em questão!
      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return grouepTransactions.fold(0.0, (sum, tr){
      return sum + (tr['value'] as double);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // Mapeando dados para um Widgets
          children: grouepTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                // Convertendo uma variavel do tipo objeto para o tipo String/double apenas com o prefixo "as"
                label: tr['day'] as String,
                value: tr['value'] as double,
                percentage: _weekTotalValue == 0 ? 0 :(tr['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
