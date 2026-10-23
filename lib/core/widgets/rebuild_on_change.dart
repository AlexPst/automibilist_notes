import 'package:flutter/widgets.dart';

/// При изменении [value] перерисовывает всё поддерево, сохраняя состояние
/// (стек навигации, открытые формы).
///
/// Нужен для валюты и единиц расхода: их читают функции форматирования,
/// а не виджеты, поэтому сами виджеты об изменении не узнают.
class RebuildOnChange extends StatefulWidget {
  const RebuildOnChange({super.key, required this.value, required this.child});

  final Object value;
  final Widget child;

  @override
  State<RebuildOnChange> createState() => _RebuildOnChangeState();
}

class _RebuildOnChangeState extends State<RebuildOnChange> {
  @override
  void didUpdateWidget(RebuildOnChange oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      void markAll(Element element) {
        element.markNeedsBuild();
        element.visitChildren(markAll);
      }

      (context as Element).visitChildren(markAll);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
