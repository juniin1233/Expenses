import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
  });

  final String label;
  final double value;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("R\$${value.toStringAsFixed(2)}"),
        const SizedBox(
          height: 5,
        ),
        // ignore: sized_box_for_whitespace
        Container(
          height: 60,
          width: 10,
          child: Stack(
            // Stack um widget que empilha outros widget
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5)
                ),
              ),
              // Um SizedBox que a altura/largura aumenta de tamanho conforme a sua porcentagem
              FractionallySizedBox(
                // heightFactor: 0.9,
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(5)
                ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(label)
      ],
    );
  }
}
