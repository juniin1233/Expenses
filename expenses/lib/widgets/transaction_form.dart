import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key, required this.onSubmit});

  final void Function(String, double) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? selectDate;

  // Colocamos essa função isolada, para podermos usar no TextInput.. Assim podemos utilizar a mesma função(codigo) em mais lugares
  _submittForm() {
    final title = _titleController.text;
    // Pegando o valor digitando no input e transformando ele em um número double. Se ele não foi um número.. Subistituir por 0.0(ZERO ponto ZERO)
    final value = double.tryParse(_valueController.text) ?? 0.0;

    // Esta fazendo uma verificação, caso o titulo estiver vazio e o valor for menor ou igual à zero
    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((picker) {
      if (picker == null) {
        return;
      }

      setState(() {
        selectDate = picker;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
              // Atributo para o curso ir para o proximo campo
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => _submittForm(),
            ),
            TextField(
              controller: _valueController,
              decoration: const InputDecoration(
                labelText: 'Valor R\$',
              ),
              // Colocando o parametro _ para identificar que não usaremos esse parametro
              onSubmitted: (_) => _submittForm(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(
                    selectDate == null
                        ? 'Nenhuma data selecionada!'
                        : DateFormat('dd/MM/y').format(selectDate!),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: const Text(
                      'Selecionar Data',
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: _submittForm,
                  child: const Text(
                    'Nova Transação',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
