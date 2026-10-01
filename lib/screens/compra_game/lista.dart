import 'package:flutter/material.dart';
import 'formulario.dart';
import '../../models/compra_game.dart';
import 'package:intl/intl.dart';

class ListaComprasGames extends StatefulWidget {
  const ListaComprasGames({super.key});

  @override
  State<ListaComprasGames> createState() => ListaComprasGamesState();
}

class ListaComprasGamesState extends State<ListaComprasGames> {
  static const _tituloAppBar = "Loja de Games";
  static const _duracaoExibicao = Duration(seconds: 1);
  static const _iconeAdicionar = Icons.add;

  final List<CompraGame> _compras = <CompraGame>[
    CompraGame(1, 59.90),
    CompraGame(2, 199.90),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: ListView.builder(
        itemCount: _compras.length,
        itemBuilder: (context, indice) {
          final compra = _compras[indice];
          return ItemCompraGame(compra: compra);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push<CompraGame>(
            context,
            MaterialPageRoute<CompraGame>(
              builder: (context) {
                return const FormularioCompraGame();
              },
            ),
          ).then(_atualiza);
        },
        child: Icon(_iconeAdicionar),
      ),
    );
  }

  void _atualiza(CompraGame? compraRecebida) {
    if (compraRecebida == null) {
      return;
    }

    Future.delayed(_duracaoExibicao, () {
      if (!mounted) {
        return;
      }
      setState(() {
        _compras.add(compraRecebida);
      });
    });
  }
}

class ItemCompraGame extends StatelessWidget {
  final CompraGame compra;

  const ItemCompraGame({super.key, required this.compra});

  @override
  Widget build(BuildContext context) {
    final NumberFormat formato = NumberFormat.simpleCurrency();
    return Card(
      child: ListTile(
        leading: const Icon(Icons.sports_esports),
        title: Text(formato.format(compra.valor).toString()),
        subtitle: Text("Pedido nº ${compra.numeroPedido}"),
      ),
    );
  }
}
