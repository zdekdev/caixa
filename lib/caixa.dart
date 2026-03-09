library;

import 'package:flutter/material.dart';

/// Um alias para [DivStyle] garantindo a compatibilidade com projetos antigos.
typedef Molde = DivStyle;

/// Um alias para [Div] mantendo a compatibilidade do pacote "Caixa".
typedef Caixa = Div;

/// Define o estilo do widget inspirado em CSS.
class DivStyle {
  final Widget? child;
  final Clip? clipBehavior;
  final double? height;
  final double? width;
  final Color? color;
  final DecorationImage? backgroundImage;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final BlendMode? backgroundBlendMode;
  final BoxShape? shape;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final Color? splashColor;

  /// Tempo de animação em transições (Exemplo: transição do base para o hover)
  final Duration? animationDuration;

  /// Estilo a ser aplicado quando o mouse estiver sobre o widget (Hover)
  final DivStyle? hoverStyle;

  /// Estilo a ser aplicado quando o widget estiver sendo pressionado (Clicado/Tapped)
  final DivStyle? pressedStyle;

  /// Estilo de texto propagado via cascata para todos os [DivText] descendentes.
  final DivTextStyle? textStyle;

  const DivStyle({
    this.child,
    this.clipBehavior,
    this.height,
    this.width,
    this.color,
    this.backgroundImage,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.gradient,
    this.backgroundBlendMode,
    this.shape,
    this.margin,
    this.padding,
    this.alignment,
    this.splashColor,
    this.animationDuration,
    this.hoverStyle,
    this.pressedStyle,
    this.textStyle,
  });

  /// Mescla estilos. Propriedades não nulas em [other] substituem as propriedades atuais.
  DivStyle merge(DivStyle? other) {
    if (other == null) return this;
    return DivStyle(
      child: other.child ?? child,
      clipBehavior: other.clipBehavior ?? clipBehavior,
      height: other.height ?? height,
      width: other.width ?? width,
      color: other.color ?? color,
      backgroundImage: other.backgroundImage ?? backgroundImage,
      border: other.border ?? border,
      borderRadius: other.borderRadius ?? borderRadius,
      boxShadow: other.boxShadow ?? boxShadow,
      gradient: other.gradient ?? gradient,
      backgroundBlendMode: other.backgroundBlendMode ?? backgroundBlendMode,
      shape: other.shape ?? shape,
      margin: other.margin ?? margin,
      padding: other.padding ?? padding,
      alignment: other.alignment ?? alignment,
      splashColor: other.splashColor ?? splashColor,
      animationDuration: other.animationDuration ?? animationDuration,
      hoverStyle: other.hoverStyle ?? hoverStyle,
      pressedStyle: other.pressedStyle ?? pressedStyle,
      textStyle: other.textStyle != null
          ? (textStyle?.merge(other.textStyle!) ?? other.textStyle)
          : textStyle,
    );
  }
}

/// Define o estilo de texto CSS-inspired para [DivText].
/// Similar ao [DivStyle], mas voltado para propriedades tipográficas.
class DivTextStyle {
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final List<String>? fontFamilyFallback;
  final double? letterSpacing;
  final double? wordSpacing;

  /// Altura de linha (equivalente ao `line-height` do CSS).
  final double? height;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final List<Shadow>? shadows;
  final TextBaseline? textBaseline;
  final TextLeadingDistribution? leadingDistribution;

  const DivTextStyle({
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.fontFamily,
    this.fontFamilyFallback,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.textAlign,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.shadows,
    this.textBaseline,
    this.leadingDistribution,
  });

  /// Mescla estilos de texto. Propriedades não nulas em [other] substituem as propriedades atuais.
  DivTextStyle merge(DivTextStyle? other) {
    if (other == null) return this;
    return DivTextStyle(
      color: other.color ?? color,
      fontSize: other.fontSize ?? fontSize,
      fontWeight: other.fontWeight ?? fontWeight,
      fontStyle: other.fontStyle ?? fontStyle,
      fontFamily: other.fontFamily ?? fontFamily,
      fontFamilyFallback: other.fontFamilyFallback ?? fontFamilyFallback,
      letterSpacing: other.letterSpacing ?? letterSpacing,
      wordSpacing: other.wordSpacing ?? wordSpacing,
      height: other.height ?? height,
      textAlign: other.textAlign ?? textAlign,
      decoration: other.decoration ?? decoration,
      decorationColor: other.decorationColor ?? decorationColor,
      decorationStyle: other.decorationStyle ?? decorationStyle,
      decorationThickness: other.decorationThickness ?? decorationThickness,
      overflow: other.overflow ?? overflow,
      maxLines: other.maxLines ?? maxLines,
      softWrap: other.softWrap ?? softWrap,
      shadows: other.shadows ?? shadows,
      textBaseline: other.textBaseline ?? textBaseline,
      leadingDistribution: other.leadingDistribution ?? leadingDistribution,
    );
  }

  /// Converte para o [TextStyle] nativo do Flutter.
  TextStyle toTextStyle() {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      shadows: shadows,
      textBaseline: textBaseline,
      leadingDistribution: leadingDistribution,
    );
  }
}

/// Propaga o [DivTextStyle] implicitamente para todos os [DivText] descendentes.
class _DivTextStyleScope extends InheritedWidget {
  final DivTextStyle effectiveStyle;

  const _DivTextStyleScope({
    required this.effectiveStyle,
    required super.child,
  });

  static DivTextStyle? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_DivTextStyleScope>()
        ?.effectiveStyle;
  }

  @override
  bool updateShouldNotify(_DivTextStyleScope oldWidget) => true;
}

/// Um "Container" super poderoso inspirado pela tag "Div" do HTML mas feito para o Flutter.
/// Aceita gerenciamento de estado automático utilizando a propriedade [listen].
/// Suporta design reativo por meio de [hoverStyle] e [pressedStyle], ideal para aplicações universais.
/// Otimizado para alta performance: É um `StatelessWidget` e só engloba em em um `Stateful`
/// local caso possua eventos de escuta (listen) ou interações de estado ativas.
class Div extends StatelessWidget {
  final DivStyle? style;
  final DivStyle? molde; // Alias para retrocompatibilidade
  final DivStyle? hoverStyle; // Estilo ao passar o mouse
  final DivStyle? pressedStyle; // Estilo ao clicar

  final Listenable?
      listen; // Automação de Estado: Ouça mudanças síncronas automaticamente

  final Widget? child;
  final Clip clipBehavior;
  final double? height;
  final double? width;
  final Color? color;
  final DecorationImage? backgroundImage;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final BlendMode? backgroundBlendMode;
  final BoxShape shape;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final Color? splashColor;
  final VoidCallback? onTap;
  final Duration? animationDuration;

  const Div({
    super.key,
    this.style,
    this.molde,
    this.hoverStyle,
    this.pressedStyle,
    this.listen,
    this.animationDuration,
    this.child,
    this.clipBehavior = Clip.none,
    this.height,
    this.width,
    this.color,
    this.backgroundImage,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.gradient,
    this.backgroundBlendMode,
    this.shape = BoxShape.rectangle,
    this.margin,
    this.padding,
    this.alignment,
    this.onTap,
    this.splashColor,
  });

  @override
  Widget build(BuildContext context) {
    if (listen != null) {
      return ListenableBuilder(
        listenable: listen!,
        builder: (context, _) => _buildContent(context),
      );
    }
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    // 1. Início mesclando estado base + antigas propriedades e propriedades em DivStyle agrapadas.
    DivStyle baseState = DivStyle(
      child: style?.child ?? molde?.child ?? child,
      clipBehavior: style?.clipBehavior ?? molde?.clipBehavior,
      height: style?.height ?? molde?.height ?? height,
      width: style?.width ?? molde?.width ?? width,
      color: style?.color ?? molde?.color ?? color,
      backgroundImage:
          style?.backgroundImage ?? molde?.backgroundImage ?? backgroundImage,
      border: style?.border ?? molde?.border ?? border,
      borderRadius: style?.borderRadius ?? molde?.borderRadius ?? borderRadius,
      boxShadow: style?.boxShadow ?? molde?.boxShadow ?? boxShadow,
      gradient: style?.gradient ?? molde?.gradient ?? gradient,
      backgroundBlendMode: style?.backgroundBlendMode ??
          molde?.backgroundBlendMode ??
          backgroundBlendMode,
      shape: style?.shape ?? molde?.shape,
      margin: style?.margin ?? molde?.margin ?? margin,
      padding: style?.padding ?? molde?.padding ?? padding,
      alignment: style?.alignment ?? molde?.alignment ?? alignment,
      splashColor: style?.splashColor ?? molde?.splashColor ?? splashColor,
      animationDuration: style?.animationDuration ??
          molde?.animationDuration ??
          animationDuration,

      // Resgata o hover e pressed style do próprio style/molde ou via root params
      hoverStyle: style?.hoverStyle ?? molde?.hoverStyle ?? hoverStyle,
      pressedStyle: style?.pressedStyle ?? molde?.pressedStyle ?? pressedStyle,
    );

    // Avalia a necessidade imperativa de ser um StatefulWidget
    final bool hasInteractiveStyles =
        baseState.hoverStyle != null || baseState.pressedStyle != null;

    if (hasInteractiveStyles) {
      // Cria e gerencia os states apenas se detectou a intenção de estilos interativos CSS-like
      return _InteractiveDiv(
          baseState: baseState,
          onTap: onTap,
          defaultShape: shape,
          defaultClip: clipBehavior);
    } else {
      // Totalmente stateless + performático para caixas comuns
      return _buildStaticContent(context, baseState);
    }
  }

  Widget _buildStaticContent(BuildContext context, DivStyle state) {
    final effectiveClip = state.clipBehavior ?? clipBehavior;
    final effectiveShape = state.shape ?? shape;
    final hasTap = onTap != null;

    Widget content = state.child ?? const SizedBox.shrink();

    // Propaga o DivTextStyle para os filhos via cascata
    if (state.textStyle != null) {
      final parentStyle = _DivTextStyleScope.of(context);
      final mergedStyle =
          parentStyle?.merge(state.textStyle!) ?? state.textStyle!;
      content = _DivTextStyleScope(effectiveStyle: mergedStyle, child: content);
    }

    if (hasTap) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: state.borderRadius as BorderRadius?,
          splashColor: state.splashColor,
          child: Padding(
            padding: state.padding ?? EdgeInsets.zero,
            child: content,
          ),
        ),
      );
    }

    if (state.animationDuration != null) {
      return AnimatedContainer(
        duration: state.animationDuration!,
        height: state.height,
        width: state.width,
        clipBehavior: effectiveClip,
        margin: state.margin,
        padding: hasTap ? EdgeInsets.zero : state.padding,
        alignment: state.alignment,
        decoration: BoxDecoration(
          color: state.color,
          image: state.backgroundImage,
          border: state.border,
          borderRadius: state.borderRadius,
          boxShadow: state.boxShadow,
          gradient: state.gradient,
          backgroundBlendMode: state.backgroundBlendMode,
          shape: effectiveShape,
        ),
        child: content,
      );
    }

    return Container(
      height: state.height,
      width: state.width,
      clipBehavior: effectiveClip,
      margin: state.margin,
      padding: hasTap ? EdgeInsets.zero : state.padding,
      alignment: state.alignment,
      decoration: BoxDecoration(
        color: state.color,
        image: state.backgroundImage,
        border: state.border,
        borderRadius: state.borderRadius,
        boxShadow: state.boxShadow,
        gradient: state.gradient,
        backgroundBlendMode: state.backgroundBlendMode,
        shape: effectiveShape,
      ),
      child: content,
    );
  }
}

class _InteractiveDiv extends StatefulWidget {
  final DivStyle baseState;
  final VoidCallback? onTap;
  final BoxShape defaultShape;
  final Clip defaultClip;

  const _InteractiveDiv({
    required this.baseState,
    this.onTap,
    required this.defaultShape,
    required this.defaultClip,
  });

  @override
  State<_InteractiveDiv> createState() => _InteractiveDivState();
}

class _InteractiveDivState extends State<_InteractiveDiv> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    DivStyle effectiveState = widget.baseState;

    if (_isHovered && widget.baseState.hoverStyle != null) {
      effectiveState = effectiveState.merge(widget.baseState.hoverStyle);
    }
    if (_isPressed && widget.baseState.pressedStyle != null) {
      effectiveState = effectiveState.merge(widget.baseState.pressedStyle);
    }

    final effectiveClip = effectiveState.clipBehavior ?? widget.defaultClip;
    final effectiveShape = effectiveState.shape ?? widget.defaultShape;
    final hasTap = widget.onTap != null;

    Widget content = effectiveState.child ?? const SizedBox.shrink();

    // Propaga o DivTextStyle para os filhos via cascata
    if (effectiveState.textStyle != null) {
      final parentStyle = _DivTextStyleScope.of(context);
      final mergedStyle = parentStyle?.merge(effectiveState.textStyle!) ??
          effectiveState.textStyle!;
      content = _DivTextStyleScope(effectiveStyle: mergedStyle, child: content);
    }

    if (hasTap) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          onHover: (hover) {
            if (widget.baseState.hoverStyle != null) {
              setState(() {
                _isHovered = hover;
              });
            }
          },
          onHighlightChanged: (highlight) {
            if (widget.baseState.pressedStyle != null) {
              setState(() {
                _isPressed = highlight;
              });
            }
          },
          borderRadius: effectiveState.borderRadius as BorderRadius?,
          splashColor: effectiveState.splashColor,
          child: Padding(
            padding: effectiveState.padding ?? EdgeInsets.zero,
            child: content,
          ),
        ),
      );
    } else {
      content = MouseRegion(
        cursor: widget.baseState.hoverStyle != null ||
                widget.baseState.pressedStyle != null
            ? SystemMouseCursors.click
            : MouseCursor.defer,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) {
          setState(() {
            _isHovered = false;
            _isPressed = false;
          });
        },
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          child: Padding(
            // Manter o padding funcionando perfeitamente igual em modo sem tap
            padding: effectiveState.padding ?? EdgeInsets.zero,
            child: content,
          ),
        ),
      );
    }

    if (effectiveState.animationDuration != null) {
      return AnimatedContainer(
        duration: effectiveState.animationDuration!,
        height: effectiveState.height,
        width: effectiveState.width,
        clipBehavior: effectiveClip,
        margin: effectiveState.margin,
        padding: EdgeInsets
            .zero, // Padding was already moved to interactable widget wrapping context
        alignment: effectiveState.alignment,
        decoration: BoxDecoration(
          color: effectiveState.color,
          image: effectiveState.backgroundImage,
          border: effectiveState.border,
          borderRadius: effectiveState.borderRadius,
          boxShadow: effectiveState.boxShadow,
          gradient: effectiveState.gradient,
          backgroundBlendMode: effectiveState.backgroundBlendMode,
          shape: effectiveShape,
        ),
        child: content,
      );
    }

    return Container(
      height: effectiveState.height,
      width: effectiveState.width,
      clipBehavior: effectiveClip,
      margin: effectiveState.margin,
      padding: EdgeInsets
          .zero, // Padding was already moved to interactable widget wrapping context
      alignment: effectiveState.alignment,
      decoration: BoxDecoration(
        color: effectiveState.color,
        image: effectiveState.backgroundImage,
        border: effectiveState.border,
        borderRadius: effectiveState.borderRadius,
        boxShadow: effectiveState.boxShadow,
        gradient: effectiveState.gradient,
        backgroundBlendMode: effectiveState.backgroundBlendMode,
        shape: effectiveShape,
      ),
      child: content,
    );
  }
}

/// Um widget de texto que herda automaticamente o [DivTextStyle] do [Div] pai
/// mais próximo via cascata, podendo sobrescrever com um estilo local.
///
/// Exemplo básico:
/// ```dart
/// Div(
///   style: DivStyle(
///     textStyle: DivTextStyle(color: Colors.blue, fontSize: 16),
///   ),
///   child: Column(children: [
///     DivText('Herda o estilo azul do pai'),
///     DivText('Sobrescreve só o tamanho', style: DivTextStyle(fontSize: 24)),
///   ]),
/// )
/// ```
class DivText extends StatelessWidget {
  final String data;

  /// Estilo local deste texto. Sobrescreve propriedades herdadas do [Div] pai.
  final DivTextStyle? style;

  const DivText(
    this.data, {
    super.key,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final inheritedStyle = _DivTextStyleScope.of(context);
    // Cascata: estilo herdado como base, estilo local sobrescreve
    final effectiveStyle = inheritedStyle?.merge(style) ?? style;

    return Text(
      data,
      style: effectiveStyle?.toTextStyle(),
      textAlign: effectiveStyle?.textAlign,
      overflow: effectiveStyle?.overflow,
      maxLines: effectiveStyle?.maxLines,
      softWrap: effectiveStyle?.softWrap,
    );
  }
}
