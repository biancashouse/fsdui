// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/stepper/stepper_with_controller.dart';

part 'step_node.mapper.dart';

@MappableClass()
class StepNode extends CL with StepNodeMappable {
  NamedSC title;
  NamedSC? subtitle;
  NamedSC content;

  StepNode({
    super.name,
    required this.title,
    this.subtitle,
    required this.content,
  });

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [];

  Step toStep(BuildContext context, int index, FCStepperState parent) {
    setParent(parent.widget.stepperNode);
    //ScrollControllerName? scName = EditablePage.name(context);
    //possiblyHighlightSelectedNode(scName);
    return Step(
      isActive: parent.currentStep >= index,
      title: title.build(context, this) ??
          fsdui.coloredText('must have a title', color: Colors.red),
      subtitle: subtitle?.build(context, this),
      content: content.build(context, this) ??
          fsdui.coloredText('must have content', color: Colors.red),
    );
  }

  @override
  String toSource(BuildContext context) => '';

  @override
  List<Widget> menuAnchorWidgets_WrapWith(BuildContext context,
    NodeAction action,
    bool? skipHeading,
    
  ) {
    return [
      if (getParent() is! StepperNode)
        ...super.menuAnchorWidgets_Heading(context, action),
      if (getParent() is! StepperNode)
        menuItemButton(context, "Stepper", StepperNode, action),
    ];
  }

  @override
  List<Type> replaceWithOnly() => [StepNode];

  @override
  List<Type> wrapCandidates() => [StepperNode];

  // @override
  // List<Type> wrapWithOnly() => [StepperNode];

  @override
  Widget? widgetLogo() => Image.asset(
    fsdui.asset('lib/assets/images/pub.dev.png'),
    width: 16,
  );

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "Step";
}
