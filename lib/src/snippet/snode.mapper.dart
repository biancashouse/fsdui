// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'snode.dart';

class SNodeMapper extends ClassMapperBase<SNode> {
  SNodeMapper._();

  static SNodeMapper? _instance;
  static SNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SNodeMapper._());
      AlgCNodeMapper.ensureInitialized();
      AppBarNodeMapper.ensureInitialized();
      NamedSCMapper.ensureInitialized();
      NamedPSMapper.ensureInitialized();
      NamedMCMapper.ensureInitialized();
      SliverAppBarNodeMapper.ensureInitialized();
      AssetImageNodeMapper.ensureInitialized();
      ChipNodeMapper.ensureInitialized();
      CrosswordNodeMapper.ensureInitialized();
      FileNodeMapper.ensureInitialized();
      FlexibleSpaceBarNodeMapper.ensureInitialized();
      StorageImageNodeMapper.ensureInitialized();
      GapNodeMapper.ensureInitialized();
      GoogleDriveIFrameNodeMapper.ensureInitialized();
      IFrameNodeMapper.ensureInitialized();
      MarkdownNodeMapper.ensureInitialized();
      PlaceholderNodeMapper.ensureInitialized();
      PollOptionNodeMapper.ensureInitialized();
      QuillTextNodeMapper.ensureInitialized();
      RichTextNodeMapper.ensureInitialized();
      ScaffoldNodeMapper.ensureInitialized();
      CustomScrollViewNodeMapper.ensureInitialized();
      StepNodeMapper.ensureInitialized();
      TextNodeMapper.ensureInitialized();
      UMLImageNodeMapper.ensureInitialized();
      YTNodeMapper.ensureInitialized();
      AlignNodeMapper.ensureInitialized();
      AspectRatioNodeMapper.ensureInitialized();
      ElevatedButtonNodeMapper.ensureInitialized();
      OutlinedButtonNodeMapper.ensureInitialized();
      TextButtonNodeMapper.ensureInitialized();
      FilledButtonNodeMapper.ensureInitialized();
      MenuItemButtonNodeMapper.ensureInitialized();
      CenterNodeMapper.ensureInitialized();
      ConstrainedBoxNodeMapper.ensureInitialized();
      ContainerNodeMapper.ensureInitialized();
      DefaultTextStyleNodeMapper.ensureInitialized();
      ExpandedNodeMapper.ensureInitialized();
      FlexibleNodeMapper.ensureInitialized();
      InteractiveViewerNodeMapper.ensureInitialized();
      IntrinsicWidthNodeMapper.ensureInitialized();
      IntrinsicHeightNodeMapper.ensureInitialized();
      PaddingNodeMapper.ensureInitialized();
      PinnedHeaderSliverNodeMapper.ensureInitialized();
      PositionedNodeMapper.ensureInitialized();
      SingleChildScrollViewNodeMapper.ensureInitialized();
      SizedBoxNodeMapper.ensureInitialized();
      SliverFloatingHeaderNodeMapper.ensureInitialized();
      SliverResizingHeaderNodeMapper.ensureInitialized();
      SliverToBoxAdapterNodeMapper.ensureInitialized();
      TabDataNodeMapper.ensureInitialized();
      TabNodeMapper.ensureInitialized();
      TargetsWrapperNodeMapper.ensureInitialized();
      CarouselViewNodeMapper.ensureInitialized();
      DashboardNodeMapper.ensureInitialized();
      DirectoryNodeMapper.ensureInitialized();
      DynamicTabBarNodeMapper.ensureInitialized();
      FlexNodeMapper.ensureInitialized();
      RowNodeMapper.ensureInitialized();
      ColumnNodeMapper.ensureInitialized();
      MenuBarNodeMapper.ensureInitialized();
      PageViewNodeMapper.ensureInitialized();
      PollNodeMapper.ensureInitialized();
      SliverListListNodeMapper.ensureInitialized();
      SplitViewNodeMapper.ensureInitialized();
      StackNodeMapper.ensureInitialized();
      StepperNodeMapper.ensureInitialized();
      SubmenuButtonNodeMapper.ensureInitialized();
      TabBarNodeMapper.ensureInitialized();
      TabBarViewNodeMapper.ensureInitialized();
      WrapNodeMapper.ensureInitialized();
      ArticleListViewNodeMapper.ensureInitialized();
      GridViewNodeMapper.ensureInitialized();
      ListViewNodeMapper.ensureInitialized();
      TextSpanNodeMapper.ensureInitialized();
      WidgetSpanNodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SNode';

  static String? _$name(SNode v) => v.name;
  static const Field<SNode, String> _f$name = Field('name', _$name, opt: true);
  static List<String>? _$tags(SNode v) => v.tags;
  static const Field<SNode, List<String>> _f$tags =
      Field('tags', _$tags, opt: true);
  static String _$uid(SNode v) => v.uid;
  static const Field<SNode, String> _f$uid =
      Field('uid', _$uid, mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$treeNodeGK(SNode v) =>
      v.treeNodeGK;
  static const Field<SNode, GlobalKey<State<StatefulWidget>>> _f$treeNodeGK =
      Field('treeNodeGK', _$treeNodeGK, mode: FieldMode.member);
  static bool _$isExpanded(SNode v) => v.isExpanded;
  static const Field<SNode, bool> _f$isExpanded =
      Field('isExpanded', _$isExpanded, mode: FieldMode.member);
  static bool? _$hidePropertiesWhileDragging(SNode v) =>
      v.hidePropertiesWhileDragging;
  static const Field<SNode, bool> _f$hidePropertiesWhileDragging = Field(
      'hidePropertiesWhileDragging', _$hidePropertiesWhileDragging,
      mode: FieldMode.member);
  static GlobalKey<State<StatefulWidget>>? _$nodeGK(SNode v) => v.nodeGK;
  static const Field<SNode, GlobalKey<State<StatefulWidget>>> _f$nodeGK =
      Field('nodeGK', _$nodeGK, mode: FieldMode.member);

  @override
  final MappableFields<SNode> fields = const {
    #name: _f$name,
    #tags: _f$tags,
    #uid: _f$uid,
    #treeNodeGK: _f$treeNodeGK,
    #isExpanded: _f$isExpanded,
    #hidePropertiesWhileDragging: _f$hidePropertiesWhileDragging,
    #nodeGK: _f$nodeGK,
  };

  @override
  final MappingHook hook = const PropertyRenameHook('snode', 'DK:snode');
  static SNode _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'SNode', 'DK:snode', '${data.value['DK:snode']}');
  }

  @override
  final Function instantiate = _instantiate;

  static SNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SNode>(map);
  }

  static SNode fromJson(String json) {
    return ensureInitialized().decodeJson<SNode>(json);
  }
}

mixin SNodeMappable {
  String toJson();
  Map<String, dynamic> toMap();
  SNodeCopyWith<SNode, SNode, SNode> get copyWith;
}

abstract class SNodeCopyWith<$R, $In extends SNode, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  SNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}
