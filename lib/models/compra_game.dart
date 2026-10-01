class CompraGame {
  final int numeroPedido;
  final double valor;

  CompraGame(this.numeroPedido, this.valor);

  @override
  String toString() {
    return "CompraGame{numeroPedido: $numeroPedido, valor: $valor}";
  }
}
