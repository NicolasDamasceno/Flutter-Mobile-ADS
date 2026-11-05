# Flutter Mobile – ADS

Atividades da disciplina de **Programação para Dispositivos Móveis**, do 4º período do curso de **Análise e Desenvolvimento de Sistemas (ADS)**, desenvolvidas em Flutter.

Os enunciados de cada atividade estão na pasta [`Atividades-Pdf`](Atividades-Pdf).

## Atividades

| Pasta | Assunto | O que foi feito |
|---|---|---|
| [`17.1-primeiro-programa`](17.1-primeiro-programa) | Primeiro programa | Tema, título "Home", sem faixa de debug, texto em português e nome "Meu App" |
| [`18.0-listview`](18.0-listview) | ListView | Lista de compras com `ListView.builder` e checkbox que muda ao ser pressionado |
| [`18.1-navigation`](18.1-navigation) | Navigation | Duas páginas com `push()`/`pop()` e com rotas nomeadas |
| [`19.1-tabbar`](19.1-tabbar) | TabBar | Três abas com `TabController`, cada uma em sua própria classe |
| [`20.0-alcool-ou-gasolina`](20.0-alcool-ou-gasolina) | Container com TextField | Calculadora álcool ou gasolina (inclui PDF de entrega) |
| [`20.2-sqflite-contatos`](20.2-sqflite-contatos) | Persistência com SqFlite | Cadastro de contatos: salvar, consultar, alterar e excluir (inclui PDF de entrega) |
| [`21.2-google-maps`](21.2-google-maps) | Google Maps | Mapa com `google_maps_flutter` configurado para Android e iOS |

## Como executar

Cada pasta é um projeto Flutter independente:

```bash
cd 18.0-listview
flutter pub get
flutter run
```

### Chave do Google Maps (21.2)

A chave da API não fica no repositório. Para rodar o projeto `21.2-google-maps`, crie:

- `android/local.properties` com a linha `MAPS_API_KEY=sua_chave`
- `ios/Flutter/Secrets.xcconfig` com a linha `MAPS_API_KEY = sua_chave`
