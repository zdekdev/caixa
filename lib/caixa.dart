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
    );
  }
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
      return _buildStaticContent(baseState);
    }
  }

  Widget _buildStaticContent(DivStyle state) {
    final effectiveClip = state.clipBehavior ?? clipBehavior;
    final effectiveShape = state.shape ?? shape;
    final hasTap = onTap != null;

    Widget content = state.child ?? const SizedBox.shrink();

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
