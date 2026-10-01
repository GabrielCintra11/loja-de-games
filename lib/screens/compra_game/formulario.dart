import 'package:flutter/material.dart';
import '../../components/editor.dart';
import '../../models/compra_game.dart';

const String _mensagemDadosInvalidos =
    'Informe o número do pedido e o valor da compra';

class FormularioCompraGame extends StatefulWidget {
  const FormularioCompraGame({super.key});

  @override
  State<FormularioCompraGame> createState() => FormularioCompraGameState();
}

class FormularioCompraGameState extends State<FormularioCompraGame> {
  final TextEditingController _controladorCampoNumeroPedido =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  static const _tituloAppBar = 'Nova Compra';
  static const _rotuloCampoValor = 'Valor da Compra';
  static const _dicaCampoValor = '0,00';

  static const _rotuloCampoNumeroPedido = 'Número do Pedido';
  static const _dicaCampoNumeroPedido = '0000';
  static const _textoBotaoConfirmar = 'Registrar Compra';

  @override
  void dispose() {
    _controladorCampoNumeroPedido.dispose();
    _controladorCampoValor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoNumeroPedido,
              rotulo: _rotuloCampoNumeroPedido,
              dica: _dicaCampoNumeroPedido,
            ),

            Editor(
              controlador: _controladorCampoValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.sports_esports,
              teclado: TextInputType.numberWithOptions(decimal: true),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _criaCompraGame(
                    context,
                    _controladorCampoNumeroPedido,
                    _controladorCampoValor,
                  );
                },
                child: const Text(_textoBotaoConfirmar),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _criaCompraGame(
  BuildContext context,
  TextEditingController controladorCampoNumeroPedido,
  TextEditingController controladorCampoValor,
) {
  final int? numeroPedido = int.tryParse(controladorCampoNumeroPedido.text);
  final double? valor = double.tryParse(
    controladorCampoValor.text.trim().replaceAll(',', '.'),
  );

  if (numeroPedido == null || valor == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(_mensagemDadosInvalidos)),
    );
    return;
  }

  final compraCriada = CompraGame(numeroPedido, valor);
  Navigator.pop(context, compraCriada);
}
