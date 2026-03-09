# Caixa (Agora com suporte a `Div`)

[![Pub Version](https://img.shields.io/pub/v/caixa.svg)](https://pub.dev/packages/caixa)
[![Flutter](https://img.shields.io/badge/flutter-friendly-02569B.svg)](https://flutter.dev)

O pacote **caixa** foi criado para simplificar e potencializar a criação de containers no Flutter, fornecendo uma solução mais flexível, inspirada e semelhante às **tags do HTML** (como a `div`).

Nesta atualização 2.0.0, introduzimos a classe **`Div`** (e `DivStyle`), trazendo gerenciamento de **estado automático** e controle de eventos de mouse (hover/click) idênticos ao CSS, **tudo sem quebrar as suas implementações antigas (Caixa / Molde)**.

## Motivação e Sugestão de Nome

Como o pacote possui a proposta de minimizar a verbosidade do `Container`, inspirando-se em tags do HTML e entregando tudo num único local, o nome de classe sugerido para novos projetos é **`Div`** em vez de `Caixa`. No entanto, **a classe `Caixa` continua funcionando examente como antes**, atuando como um "alias" (apelido) da nova superclasse `Div`. O mesmo ocorre com `Molde`, que agora aponta para `DivStyle`.

---

## O que há de novo?

1. **Tag Unificada (`Div`):** A classe principal que funciona de forma declarativa e inteligente.
2. **Atualização Automática de Estado (`listen`):** Chega de usar `StatefulWidget` só para atualizar a cor, padding ou conteúdo da tela. Agora a `Div` escuta variáveis nativamente (via `listen`) e se reconstrói sozinha!
3. **Estilos e Estados Interativos (`hoverStyle`, `pressedStyle`):** Trate de eventos de mouse (Hover em Web/Desktop) de forma nativa igual os pseudoelementos `:hover` e `:active` do CSS, tudo unificado dentro do **`DivStyle`**.
4. **Alta Performance:** A `Div` é um `StatelessWidget`. Ela só escala sua complexidade nativamente caso encontre um ouvinte `listen`, `hoverStyle` ou `pressedStyle` nela ou em seu estilo base. Ou seja, você não terá dor de cabeça com perda de performance, mesmo empilhando várias `Div` juntas!
5. **Animações Nativas:** Basta passar o parâmetro `animationDuration` e qualquer troca de estado ou estilo passará a ser animada suavemente (como o tradicional `transition: all` do CSS).
6. **`DivText` e `DivTextStyle`:** Widget de texto com herança de estilo em cascata — defina `textStyle` no `DivStyle` do pai e todos os `DivText` descendentes herdam automaticamente, podendo sobrescrever localmente.
7. **Formatação inline no `DivText`:** Destaque palavras ou trechos dentro da própria string com uma mini-linguagem inspirada no Markdown: `**negrito**`, `*itálico*`, `~~tachado~~`, `__sublinhado__` e `[texto]{#cor,bold,size=N}` para estilos totalmente customizados.

---

## Instalação

Adicione o pacote ao seu `pubspec.yaml` e baixe-o via pub:
```console
$ flutter pub add caixa
```

E no seu código, basta importar:
```dart
import 'package:caixa/caixa.dart';
```

---

## Exemplos e Como Usar

### 1. Reatividade Automática - Problema de estado resolvido

Normalmente, para atualizar um valor num `Container`, você precisa de um `StatefulWidget` e chamar o `setState()`. Agora, a `Div` faz isso sozinha! Basta passar um `ValueNotifier` e a tag se refaz apenas quando o item modificar:

```dart
final ValueNotifier<int> _contador = ValueNotifier(0);

// Dentro do seu build:
Div(
  listen: _contador, // Observa a variável! Atualiza o estado automaticamente!
  onTap: () {
    _contador.value++;
  },
  padding: const EdgeInsets.all(20),
  color: Colors.blueAccent,
  child: Text(
    "Cliques: ${_contador.value}", 
    style: const TextStyle(color: Colors.white)
  ),
);
```

### 2. Estilos reativos: Hover, Pressed e Animação

A `Div` tem propriedades para lidar de forma nativa com quando o mouse passa por cima (`hoverStyle`) e quando o botão do mouse ou dedo toca na tela (`pressedStyle`):

```dart
Div(
  animationDuration: const Duration(milliseconds: 300), // anima suavemente!
  
  style: DivStyle(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.grey),

    // Ao passar o mouse (Web/Desktop) fica tudo agrupado no DivStyle!
    hoverStyle: DivStyle(
      color: Colors.blue[100],
      border: Border.all(color: Colors.blue),
      boxShadow: [
        BoxShadow(blurRadius: 10, color: Colors.blue.withOpacity(0.3))
      ],
    ),
    
    // Ao clicar/pressionar (Mobile/Desktop)
    pressedStyle: DivStyle(
      color: Colors.blue[300],
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13), // simula efeito de "apertar"
    ),
  ),
  
  onTap: () => print("Fui clicado!"),
  child: const Text("Botão Interativo CSS-like"),
);
```

Você também pode armazenar um `DivStyle` em uma variável e **reutilizá-lo em várias `Div`**, assim como se faz com classes CSS:

```dart
// Defina o estilo uma vez...
final buttonStyle = DivStyle(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  color: Colors.grey[200],
  borderRadius: BorderRadius.circular(8),
  border: Border.all(color: Colors.grey),
  hoverStyle: DivStyle(
    color: Colors.blue[100],
    border: Border.all(color: Colors.blue),
  ),
  pressedStyle: DivStyle(
    color: Colors.blue[300],
  ),
);

// ...e aplique em quantas Div quiser!
Row(
  children: [
    Div(
      animationDuration: const Duration(milliseconds: 200),
      style: buttonStyle,
      onTap: () => print("Salvar"),
      child: const Text("Salvar"),
    ),
    Div(
      animationDuration: const Duration(milliseconds: 200),
      style: buttonStyle,
      onTap: () => print("Cancelar"),
      child: const Text("Cancelar"),
    ),
    Div(
      animationDuration: const Duration(milliseconds: 200),
      style: buttonStyle,
      onTap: () => print("Editar"),
      child: const Text("Editar"),
    ),
  ],
);
```

### 3. Retrocompatibilidade: Usando a tradicional `Caixa` com o `Molde`

Para preservar o funcionamento clássico perfeitamente, garantimos que sua sintaxe atual continuará funcionando de forma exemplar. Você cria um `Molde` e aplica na `Caixa`:

```dart
// Criando um reuso
var moldeButton = Molde(
  height: 80,
  width: 150,
  color: const Color(0xFF00838F),
  borderRadius: BorderRadius.circular(5),
  boxShadow: const [
    BoxShadow(
      blurRadius: 10,
      color: Color.fromARGB(96, 0, 0, 0)
    )
  ],
);

// Botão 01 com configurações de toque prontas
Caixa(
  molde: moldeButton,  
  onTap: () {
    print("Botão 01");
  },                 
  child: const Center(
    child: Text(
      "Botão 01",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
    ),
  ),
);
```

---

## DivText e DivTextStyle

### 4. Texto com estilo em cascata via `DivTextStyle`

O `DivText` é o companheiro do `Div` para texto. Basta definir um `textStyle` dentro do `DivStyle` do `Div` pai e **todos os `DivText` descendentes herdam o estilo automaticamente**, funcionando como o `color` e `font-size` em cascata do CSS.

```dart
Div(
  style: DivStyle(
    padding: const EdgeInsets.all(16),
    color: Colors.white,
    textStyle: DivTextStyle(
      color: Colors.black87,
      fontSize: 15,
      fontFamily: 'Roboto',
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DivText('Esse texto herda cor e fonte do pai.'),
      DivText('Esse também — sem repetir nada!'),
      DivText(
        'Esse sobrescreve só o tamanho.',
        style: DivTextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    ],
  ),
);
```

Os estilos se **acumulam em cascata**: um `Div` dentro de outro `Div` mescla os `DivTextStyle` de todos os ancestrais, e o estilo local do `DivText` sempre vence ao final.

```dart
Div(
  style: DivStyle(
    textStyle: DivTextStyle(color: Colors.blue, fontSize: 16),
  ),
  child: Div(
    style: DivStyle(
      textStyle: DivTextStyle(fontWeight: FontWeight.bold), // acumula
    ),
    child: DivText('Azul, 16px e bold — herda tudo dos dois pais.'),
  ),
);
```

---

### 5. Formatação inline dentro das strings do `DivText`

O `DivText` suporta uma mini-linguagem de marcação inspirada no Markdown para destacar palavras ou trechos **dentro da própria string**, sem precisar montar um `RichText` manualmente.

| Sintaxe | Resultado |
|---|---|
| `**texto**` | **negrito** |
| `*texto*` | *itálico* |
| `~~texto~~` | ~~tachado~~ |
| `__texto__` | sublinhado |
| `[texto]{opções}` | estilo customizado |

**Opções do `[texto]{...}`** (separadas por vírgula, sem espaço entre elas):

| Opção | Exemplo | Descrição |
|---|---|---|
| `#RRGGBB` | `#FF5733` | Cor no formato hexadecimal |
| `#AARRGGBB` | `#80FF5733` | Hex com canal alfa |
| `color=#RRGGBB` | `color=#1E90FF` | Cor (forma explícita) |
| `size=N` / `fontSize=N` | `size=20` | Tamanho da fonte |
| `bold` | | Negrito |
| `italic` | | Itálico |
| `underline` | | Sublinhado |
| `strike` / `strikethrough` | | Tachado |

Os marcadores podem ser combinados livremente com o `DivTextStyle` herdado do pai — o span inline adiciona ou sobrescreve apenas as propriedades que declare:

```dart
// Exemplo 1: destaque de cor num trecho
DivText('**Lorem Ipsum** is simply [dummy text]{#FF5733} of the printing.');

// Exemplo 2: combinação de opções
DivText('[Clique aqui]{#1E90FF,bold,underline} para continuar.');

// Exemplo 3: preço em destaque
DivText('Valor: [R\$ 59,90]{#2ECC71,size=22,bold} por mês.');

// Exemplo 4: vários marcadores estilo Markdown
DivText('*Atenção:* ~~versão antiga~~ __nova versão disponível__.');

// Exemplo 5: dentro de um Div com cascata ativa
Div(
  style: DivStyle(
    textStyle: DivTextStyle(color: Colors.black87, fontSize: 16),
  ),
  child: Column(
    children: [
      DivText('Texto normal herdado do pai.'),
      DivText('Palavra [importante]{#E74C3C,bold} no meio da frase.'),
    ],
  ),
);
```

> **Dica de segurança de caracteres:** um `*` ou `[` isolado (sem o par correspondente) é tratado como texto literal — você não precisa escapar caracteres em strings normais. Apenas o padrão completo (`**…**`, `[…]{…}`, etc.) é interpretado como marcação. Se a string não contiver nenhum marcador, o widget usa um `Text` simples sem nenhum custo extra.

---

## Por que usar o package Caixa (`Div`)?

1. **Código Imensamente Mais Limpo:**
Em vez de aninhar `Container` -> `Material` -> `InkWell` -> `MouseRegion` e afins para obter hover e click, a `Div` te entrega um parâmetro universal que mescla todas as intenções de design.
2. **Reutilização de Configurações:**
Com a classe `DivStyle` (ou o clássico `Molde`), você cria padrões de design, cores, bordas, e réplica em inúmeras divs, economizando bastante código e facilitando a manutenção global do visual.
3. **Ações Integradas sem Complicação:**
Suporte nativo para `onTap`, dispensando envolver com o `GestureDetector` manualmente. Você conta de quebra com o `splashColor` para feedback instantâneo no mobile.
