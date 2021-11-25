import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(
      {Key? key, required this.transactions, required this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "Nenhuma Transação Cadastrada!",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];

              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 8,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text("R\$${transaction.value}"),
                      ),
                    ),
                  ),
                  title: Text(
                    transaction.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat("d MMM y").format(transaction.date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? TextButton.icon(
                          onPressed: () => onRemove(transaction.id),
                          icon: Icon(Icons.delete),
                          label: Text("Excluir"),
                        )
                      : IconButton(
                          onPressed: () => onRemove(transaction.id),
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).primaryColor,
                        ),
                ),
              );
            },
          );
  }
}
