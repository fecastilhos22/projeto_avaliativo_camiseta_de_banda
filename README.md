# projeto_avaliativo_camiseta_de_banda

# Catálogo de Camisetas 

## Descrição

Este projeto foi desenvolvido em Flutter como atividade prática do curso, utilizando a arquitetura MVVM.

O aplicativo permite visualizar um catálogo de camisetas, pesquisar produtos, aplicar filtros por preço, visualizar os detalhes e realizar uma compra com validações dos dados informados.

---

## Funcionalidades

- Carregamento das camisetas através de arquivo JSON.
- Exibição em Lista e Grade.
- Pesquisa por título.
- Filtro por preço mínimo e máximo.
- Navegação para tela de compra.
- Escolha do tamanho.
- Controle de quantidade.
- Parcelamento em até 6 vezes.
- Cálculo automático do valor total.
- Aplicação de juros conforme o número de parcelas.
- Validação dos campos obrigatórios.
- Criação da entidade Compra.
- Conversão da compra para JSON.
- Retorno ao catálogo após finalizar a compra.

---

## Arquitetura

O projeto foi desenvolvido utilizando a arquitetura MVVM.

- Model
- View
- ViewModel
- Repository

---

## Tecnologias

- Flutter
- Dart
- Material Design
- JSON
- MVVM

---

## Estrutura do Projeto

```
lib/
 ├── app/
 │    └── data/
 │         ├── models/
 │         ├── repositories/
 │         └── datasources/
 │
 ├── view/
 ├── viewModel/
 └── main.dart
```

---

## Como executar

1. Clonar o repositório.
2. Executar:

```bash
flutter pub get
```

3. Executar:

```bash
flutter run
```

---

## Autor

Fernanda Castilhos