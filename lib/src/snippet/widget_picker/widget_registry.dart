import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/snodes/crossword_node.dart';
import 'widget_entry.dart';

final List<WidgetEntry> widgetRegistry = [
  // layout
  const WidgetEntry(label: 'Align', type: AlignNode, category: WidgetCategory.layout),
  const WidgetEntry(label: 'Aspect Ratio', type: AspectRatioNode, category: WidgetCategory.layout),
  const WidgetEntry(label: 'Center', type: CenterNode, category: WidgetCategory.layout),
  const WidgetEntry(label: 'ConstrainedBox', type: ConstrainedBoxNode, category: WidgetCategory.layout),
  const WidgetEntry(label: 'Container', type: ContainerNode, category: WidgetCategory.layout),
  const WidgetEntry(label: 'DefaultTextStyle', type: DefaultTextStyleNode, category: WidgetCategory.layout),
  const WidgetEntry(label: 'Padding', type: PaddingNode, category: WidgetCategory.layout),
  const WidgetEntry(label: 'Scaffold', type: ScaffoldNode, category: WidgetCategory.layout),
  const WidgetEntry(label: 'SizedBox', type: SizedBoxNode, category: WidgetCategory.layout),
  // flex
  const WidgetEntry(label: 'Column', type: ColumnNode, category: WidgetCategory.flex),
  const WidgetEntry(label: 'Expanded', type: ExpandedNode, category: WidgetCategory.flex),
  const WidgetEntry(label: 'Flexible', type: FlexibleNode, category: WidgetCategory.flex),
  const WidgetEntry(label: 'IntrinsicHeight', type: IntrinsicHeightNode, category: WidgetCategory.flex),
  const WidgetEntry(label: 'IntrinsicWidth', type: IntrinsicWidthNode, category: WidgetCategory.flex),
  const WidgetEntry(label: 'Row', type: RowNode, category: WidgetCategory.flex),
  const WidgetEntry(label: 'Wrap', type: WrapNode, category: WidgetCategory.flex),
  // scroll
  const WidgetEntry(label: 'GridView', type: GridViewNode, category: WidgetCategory.scroll),
  const WidgetEntry(label: 'InteractiveViewer', type: InteractiveViewerNode, category: WidgetCategory.scroll),
  const WidgetEntry(label: 'ListView', type: ListViewNode, category: WidgetCategory.scroll),
  const WidgetEntry(label: 'PageView', type: PageViewNode, category: WidgetCategory.scroll),
  const WidgetEntry(label: 'SingleChildScrollView', type: SingleChildScrollViewNode, category: WidgetCategory.scroll),
  const WidgetEntry(label: 'ArticleListView', type: ArticleListViewNode, category: WidgetCategory.scroll),
  // stack
  const WidgetEntry(label: 'Positioned', type: PositionedNode, category: WidgetCategory.stack),
  const WidgetEntry(label: 'SplitView', type: SplitViewNode, category: WidgetCategory.stack),
  const WidgetEntry(label: 'Stack', type: StackNode, category: WidgetCategory.stack),
  // slivers
  const WidgetEntry(label: 'CustomScrollView', type: CustomScrollViewNode, category: WidgetCategory.sliver),
  const WidgetEntry(label: 'PinnedHeaderSliver', type: PinnedHeaderSliverNode, category: WidgetCategory.sliver),
  const WidgetEntry(label: 'SliverAppBar', type: SliverAppBarNode, category: WidgetCategory.sliver),
  const WidgetEntry(label: 'SliverFloatingHeader', type: SliverFloatingHeaderNode, category: WidgetCategory.sliver),
  const WidgetEntry(label: 'SliverList.list', type: SliverListListNode, category: WidgetCategory.sliver),
  const WidgetEntry(label: 'SliverResizingHeader', type: SliverResizingHeaderNode, category: WidgetCategory.sliver),
  const WidgetEntry(label: 'SliverToBoxAdapter', type: SliverToBoxAdapterNode, category: WidgetCategory.sliver),
  // text
  const WidgetEntry(label: 'Markdown', type: MarkdownNode, category: WidgetCategory.text),
  const WidgetEntry(label: 'QuillText', type: QuillTextNode, category: WidgetCategory.text, keywords: ['rich', 'quill']),
  const WidgetEntry(label: 'RichText', type: RichTextNode, category: WidgetCategory.text),
  const WidgetEntry(label: 'Text', type: TextNode, category: WidgetCategory.text),
  const WidgetEntry(label: 'TextSpan', type: TextSpanNode, category: WidgetCategory.text),
  const WidgetEntry(label: 'WidgetSpan', type: WidgetSpanNode, category: WidgetCategory.text),
  // button
  const WidgetEntry(label: 'ElevatedButton', type: ElevatedButtonNode, category: WidgetCategory.button),
  const WidgetEntry(label: 'FilledButton', type: FilledButtonNode, category: WidgetCategory.button),
  const WidgetEntry(label: 'IconButton', type: IconButtonNode, category: WidgetCategory.button),
  const WidgetEntry(label: 'OutlinedButton', type: OutlinedButtonNode, category: WidgetCategory.button),
  const WidgetEntry(label: 'TextButton', type: TextButtonNode, category: WidgetCategory.button),
  // navigation
  const WidgetEntry(label: 'Chip', type: ChipNode, category: WidgetCategory.navigation),
  const WidgetEntry(label: 'MenuBar', type: MenuBarNode, category: WidgetCategory.navigation),
  const WidgetEntry(label: 'MenuItemButton', type: MenuItemButtonNode, category: WidgetCategory.navigation),
  const WidgetEntry(label: 'SubmenuButton', type: SubmenuButtonNode, category: WidgetCategory.navigation),
  const WidgetEntry(label: 'Tab', type: TabNode, category: WidgetCategory.navigation),
  const WidgetEntry(label: 'TabBar', type: TabBarNode, category: WidgetCategory.navigation),
  const WidgetEntry(label: 'TabBarView', type: TabBarViewNode, category: WidgetCategory.navigation),
  const WidgetEntry(label: 'DynamicTabBar', type: DynamicTabBarNode, category: WidgetCategory.navigation),
  const WidgetEntry(label: 'TabData', type: TabDataNode, category: WidgetCategory.navigation),
  // image
  const WidgetEntry(label: 'Algorithm', type: AlgCNode, category: WidgetCategory.image, keywords: ['algc', 'diagram']),
  const WidgetEntry(label: 'Asset Image', type: AssetImageNode, category: WidgetCategory.image, keywords: ['image', 'asset', 'local']),
  const WidgetEntry(label: 'Carousel', type: CarouselNode, category: WidgetCategory.image, keywords: ['slider', 'gallery']),
  const WidgetEntry(label: 'Firebase Storage Image', type: StorageImageNode, category: WidgetCategory.image, keywords: ['firebase', 'image', 'storage', 'cloud']),
  const WidgetEntry(label: 'UML', type: UMLImageNode, category: WidgetCategory.image, keywords: ['diagram', 'class']),
  WidgetEntry(label: 'Crossword', type: CrosswordNode, category: WidgetCategory.image, keywords: const ['crossword']),
  // media
  const WidgetEntry(label: 'Directory', type: DirectoryNode, category: WidgetCategory.media, keywords: ['folder', 'files']),
  const WidgetEntry(label: 'File', type: FileNode, category: WidgetCategory.media),
  const WidgetEntry(label: 'Google Drive iframe', type: GoogleDriveIFrameNode, category: WidgetCategory.media, keywords: ['google', 'drive', 'embed', 'gdoc']),
  const WidgetEntry(label: 'iframe', type: IFrameNode, category: WidgetCategory.media, keywords: ['embed', 'web', 'html']),
  const WidgetEntry(label: 'Youtube', type: YTNode, category: WidgetCategory.media, keywords: ['video', 'youtube', 'yt']),
  // content
  const WidgetEntry(label: 'Gap', type: GapNode, category: WidgetCategory.content, keywords: ['space', 'spacer']),
  const WidgetEntry(label: 'Hotspots', type: TargetsWrapperNode, category: WidgetCategory.content, keywords: ['target', 'callout', 'annotation']),
  const WidgetEntry(label: 'Placeholder', type: PlaceholderNode, category: WidgetCategory.content),
  const WidgetEntry(label: 'Poll', type: PollNode, category: WidgetCategory.content),
  const WidgetEntry(label: 'PollOption', type: PollOptionNode, category: WidgetCategory.content),
  const WidgetEntry(label: 'Step', type: StepNode, category: WidgetCategory.content),
  const WidgetEntry(label: 'Stepper', type: StepperNode, category: WidgetCategory.content),
];
