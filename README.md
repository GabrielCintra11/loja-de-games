# Loja de Games

App Flutter de cadastro e listagem de compras de games.

**Aluno:** Gabriel Andrade Cintra — Tema 9 (Loja de Games)

## Entidade

`CompraGame` (`lib/models/compra_game.dart`)

- `numeroPedido` (`int`) — número do pedido
- `valor` (`double`) — valor da compra

Os dados existem **somente em memória**: não há banco de dados nem persistência.
Ao reiniciar o aplicativo, a lista volta aos dois registros iniciais
(pedido 1 — R$ 59,90 e pedido 2 — R$ 199,90).

## Fluxo

1. Tela inicial (`lib/screens/compra_game/lista.dart`): `ListView.builder` com
   `Card` + `ListTile` e o ícone `Icons.sports_esports`.
2. `FloatingActionButton` abre o formulário com
   `Navigator.push` + `MaterialPageRoute`.
3. Formulário (`lib/screens/compra_game/formulario.dart`): campos
   **Número do Pedido** e **Valor da Compra** com `TextEditingController`.
4. Validação com `int.tryParse` e `double.tryParse` (aceita `349,90` e `349.90`).
   Com dados inválidos a compra não é criada e o usuário recebe um aviso.
5. `Navigator.pop` devolve o `CompraGame` para a lista.
6. A lista exibe o novo item com `setState` após `Future.delayed` de 1 segundo.

Valores monetários são formatados no padrão brasileiro com `intl`
(`Intl.defaultLocale = "pt_BR"`), por exemplo `R$ 59,90`.

## Executar

```bash
flutter pub get
flutter run
```

## Verificar

```bash
flutter analyze
flutter test
```

## Evidências

- `evidencias/lista.png` — tela da lista com os registros
- `evidencias/formulario.png` — tela do formulário preenchido
