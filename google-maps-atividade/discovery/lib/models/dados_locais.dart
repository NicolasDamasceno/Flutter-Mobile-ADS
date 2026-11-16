import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'categoria.dart';
import 'local.dart';

const Local _mcDonaldsFrei = Local(
  id: 'mcdonalds-frei-serafim',
  nome: "McDonald's Frei Serafim",
  descricao: 'Rede de fast food com hambúrgueres, batata frita, sobremesas e café.',
  endereco: 'Av. Frei Serafim - Centro, Teresina - PI',
  posicao: LatLng(-5.0852171, -42.7996675),
);

const Local _vasto = Local(
  id: 'vasto-teresina',
  nome: 'Vasto Teresina',
  descricao:
      'Restaurante do grupo Coco Bambu com cozinha contemporânea, frutos do mar e sobremesas.',
  endereco: 'Rua Prof. Joca Vieira, 1269 - Jóquei, Teresina - PI',
  posicao: LatLng(-5.0694599, -42.7881353),
);

const List<Categoria> categoriasCadastradas = [
  Categoria(
    nome: 'Bars & Hotels',
    icone: Icons.sports_bar,
    locais: [
      Local(
        id: 'zero-grau-rio-poty',
        nome: 'Zero Grau Choperia',
        descricao: 'Choperia com chope gelado e petiscos de boteco.',
        endereco:
            'Av. Mal. Castelo Branco, 911, Loja 407A (Shopping Rio Poty) - Porenquanto, Teresina - PI',
        posicao: LatLng(-5.0771827, -42.8016318),
      ),
      Local(
        id: 'quiosque-caneleiro',
        nome: 'Quiosque Caneleiro',
        descricao: 'Bar às margens do Rio Poti, ponto de encontro para o happy hour.',
        endereco: 'Av. Raul Lopes, 431 - Jóquei, Teresina - PI',
        posicao: LatLng(-5.0785517, -42.7965331),
      ),
      Local(
        id: 'ibis-teresina',
        nome: 'ibis Teresina',
        descricao: 'Hotel econômico da rede Accor no Centro da cidade.',
        endereco: 'Rua Primeiro de Maio, 450 - Centro, Teresina - PI',
        posicao: LatLng(-5.0915556, -42.8032007),
      ),
      Local(
        id: 'metropolitan-hotel',
        nome: 'Metropolitan Hotel',
        descricao:
            'Hotel no Centro com piscina ao ar livre e terraço, perto da Igreja de São Benedito.',
        endereco: 'Av. Frei Serafim, 1696 - Centro, Teresina - PI',
        posicao: LatLng(-5.0901002, -42.8096682),
      ),
      Local(
        id: 'luxor-hotel',
        nome: 'Rede Andrade Luxor Hotel',
        descricao: 'Hotel tradicional na Praça Marechal Deodoro, no Centro histórico.',
        endereco: 'Praça Mal. Deodoro da Fonseca, 310 - Centro, Teresina - PI',
        posicao: LatLng(-5.0897119, -42.8167097),
      ),
    ],
  ),
  Categoria(
    nome: 'Fine Dining',
    icone: Icons.volunteer_activism,
    locais: [
      Local(
        id: 'grand-cru',
        nome: 'Grand Cru',
        descricao: 'Casa de vinhos e restaurante contemporâneo com ampla carta de rótulos.',
        endereco: 'Av. Ininga, 996 - Jóquei, Teresina - PI',
        posicao: LatLng(-5.0745, -42.7949),
      ),
      Local(
        id: 'zio-cucina',
        nome: 'Zio Cucina',
        descricao: 'Restaurante italiano com massas frescas e pratos clássicos da Itália.',
        endereco: 'Av. Ininga, 717 - Jóquei, Teresina - PI',
        posicao: LatLng(-5.0720, -42.7956),
      ),
      _vasto,
      Local(
        id: 'coco-bambu',
        nome: 'Coco Bambu',
        descricao: 'Restaurante especializado em frutos do mar, com pratos para compartilhar.',
        endereco: 'Av. Dom Severino - Fátima, Teresina - PI',
        posicao: LatLng(-5.0697401, -42.7881650),
      ),
      Local(
        id: 'santa-grelha',
        nome: 'Santa Grelha',
        descricao: 'Steakhouse premium especializada em carnes grelhadas.',
        endereco:
            'Av. Mal. Castelo Branco, 911 (Shopping Rio Poty) - Porenquanto, Teresina - PI',
        posicao: LatLng(-5.0771827, -42.8016318),
      ),
    ],
  ),
  Categoria(
    nome: 'Cafes',
    icone: Icons.house,
    locais: [
      _mcDonaldsFrei,
      Local(
        id: 'kopenhagen-joquei',
        nome: 'Kopenhagen Teresina Jóquei',
        descricao: 'Loja de chocolates finos com cafeteria.',
        endereco:
            'Av. Ininga, 1201, Loja V175 (Riverside Shopping) - Jóquei, Teresina - PI',
        posicao: LatLng(-5.0783, -42.7953),
      ),
      Local(
        id: 'clean-cafe-riverside',
        nome: 'Clean Café Riverside',
        descricao: 'Cafeteria com café da manhã, brunch e cappuccino.',
        endereco: 'Av. Ininga, 1201 (Riverside Shopping) - Jóquei, Teresina - PI',
        posicao: LatLng(-5.0789, -42.7946),
      ),
      Local(
        id: 'vito-caffe-vino',
        nome: 'Vito Caffè & Vino',
        descricao: 'Cafeteria e bar de vinhos.',
        endereco:
            'Av. Mal. Castelo Branco, 911 (Shopping Rio Poty) - Porenquanto, Teresina - PI',
        posicao: LatLng(-5.0771827, -42.8016318),
      ),
      Local(
        id: 'bellacasa-colonial',
        nome: 'BellaCasa Colonial Café',
        descricao: 'Café colonial com quentinhas no almoço e rodízio de pizza à noite.',
        endereco: 'Rua Gov. Joca Pires, 1359 - Jóquei, Teresina - PI',
        posicao: LatLng(-5.0741210, -42.7894769),
      ),
    ],
  ),
  Categoria(
    nome: 'Nearby',
    icone: Icons.route,
    mostrarQuantidade: false,
    locais: [
      Local(
        id: 'coxinha-no-cone',
        nome: 'Coxinha no Cone',
        descricao: 'Coxinhas servidas no cone, com recheios variados.',
        endereco: 'Rua Coelho de Resende - Centro, Teresina - PI',
        posicao: LatLng(-5.0862549, -42.8074679),
      ),
      Local(
        id: 'chiquinho-sorvetes',
        nome: 'Chiquinho Sorvetes',
        descricao: 'Sorveteria com casquinhas, sundaes e milkshakes.',
        endereco: 'Rua Coelho de Resende, 179 - Centro, Teresina - PI',
        posicao: LatLng(-5.0865734, -42.8073113),
      ),
      Local(
        id: 'kina-kana',
        nome: 'Kina Kana Pastelaria',
        descricao: 'Pastelaria com pastéis fritos na hora e caldo de cana.',
        endereco: 'Rua Barroso - Centro, Teresina - PI',
        posicao: LatLng(-5.0882449, -42.8160597),
      ),
    ],
  ),
  Categoria(
    nome: 'Fast Food',
    icone: Icons.fastfood,
    locais: [
      _mcDonaldsFrei,
      Local(
        id: 'burger-king-frei-serafim',
        nome: 'Burger King Frei Serafim',
        descricao: 'Fast food de hambúrgueres grelhados no fogo, como o Whopper.',
        endereco: 'Av. Frei Serafim - Centro, Teresina - PI',
        posicao: LatLng(-5.0844045, -42.7985405),
      ),
      Local(
        id: 'bebelu-riverside',
        nome: 'Bebelu Sanduíches',
        descricao: 'Lanchonete de sanduíches, combos e milkshakes.',
        endereco:
            'Av. Ininga, 1201, Loja H128 (Riverside Shopping) - Jóquei, Teresina - PI',
        posicao: LatLng(-5.0785881, -42.7949879),
      ),
      Local(
        id: 'johnny-rockets-rio-poty',
        nome: 'Johnny Rockets',
        descricao: 'Hamburgueria americana no estilo das lanchonetes dos anos 50.',
        endereco:
            'Av. Mal. Castelo Branco, 911 (Shopping Rio Poty) - Porenquanto, Teresina - PI',
        posicao: LatLng(-5.0771827, -42.8016318),
      ),
      Local(
        id: 'bobs-teresina-shopping',
        nome: "Bob's Teresina Shopping",
        descricao: 'Rede brasileira de fast food, famosa pelo milkshake de Ovomaltine.',
        endereco: 'Av. Raul Lopes, 1000 (Teresina Shopping) - Noivos, Teresina - PI',
        posicao: LatLng(-5.0848783, -42.7888986),
      ),
    ],
  ),
  Categoria(
    nome: 'Featured Foods',
    icone: Icons.cake,
    locais: [
      Local(
        id: 'gula-verde',
        nome: 'Gula Verde',
        descricao: 'Bistrô de comida funcional e saudável, com opções sem glúten.',
        endereco: 'Rua Napoleão Lima, 1263 - Jóquei, Teresina - PI',
        posicao: LatLng(-5.0762534, -42.7883889),
      ),
      Local(
        id: 'subway-frei-serafim',
        nome: 'Subway Frei Serafim',
        descricao: 'Sanduíches montados na hora, com pão e recheios à escolha.',
        endereco: 'Av. Frei Serafim, 2461 - Centro, Teresina - PI',
        posicao: LatLng(-5.0863265, -42.8035065),
      ),
      Local(
        id: 'flow-fresh-to-go',
        nome: 'Flow Fresh To Go',
        descricao: 'Comida saudável e prática: bowls, wraps e saladas para levar.',
        endereco: 'Av. Dom Severino - Fátima, Teresina - PI',
        posicao: LatLng(-5.0702, -42.7805),
      ),
      _vasto,
      Local(
        id: 'gourmet-fit',
        nome: 'Bistrô Gourmet Fit',
        descricao: 'Bistrô de refeições fit e saudáveis.',
        endereco: 'Av. Odilon Araújo, 236 - Piçarra, Teresina - PI',
        posicao: LatLng(-5.1010021, -42.7933414),
      ),
    ],
  ),
];
