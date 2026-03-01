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

## Por que usar o package Caixa (`Div`)?

1. **Código Imensamente Mais Limpo:**
Em vez de aninhar `Container` -> `Material` -> `InkWell` -> `MouseRegion` e afins para obter hover e click, a `Div` te entrega um parâmetro universal que mescla todas as intenções de design.
2. **Reutilização de Configurações:**
Com a classe `DivStyle` (ou o clássico `Molde`), você cria padrões de design, cores, bordas, e réplica em inúmeras divs, economizando bastante código e facilitando a manutenção global do visual.
3. **Ações Integradas sem Complicação:**
Suporte nativo para `onTap`, dispensando envolver com o `GestureDetector` manualmente. Você conta de quebra com o `splashColor` para feedback instantâneo no mobile.
