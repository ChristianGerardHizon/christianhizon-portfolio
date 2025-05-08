import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group_item.dart';

class DynamicGroupTabItem {
  final String title;
  final Widget? icon;
  final Widget? child;
  final List<DynamicGroupItem> children;

  DynamicGroupTabItem({
    required this.title,
    required this.children,
    this.icon,
    this.child,
  });
}

class DynamicGroupTabs extends HookWidget {
  const DynamicGroupTabs(
      {super.key,
      required this.header,
      required this.tabs,
      this.titleStyle,
      this.helper,
      this.padding = EdgeInsets.zero,
      required this.tabController});

  final TabController tabController;
  final List<DynamicGroupTabItem> tabs;
  final String? header;
  final String? helper;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    useEffect(() {
      tabController.addListener(() {
        selectedIndex.value = tabController.index;
      });
      return null;
    }, [tabController]);

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header is String)
            Padding(
              padding: EdgeInsets.only(left: padding.horizontal, bottom: 4),
              child: Text(
                header!.toUpperCase(),
                style: titleStyle ??
                    Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
              ),
            ),
          const SizedBox(height: 4),
          Card(
            child: Column(
              children: [
                TabBar(
                  controller: tabController,
                  tabs: tabs.map((tab) {
                    return Tab(
                      icon: tab.icon,
                      child: tab.child ?? Text(tab.title),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                // This will size to content and work inside scroll views
                IndexedStack(
                  index: selectedIndex.value,
                  children: tabs.map((tab) {
                    return ListView.separated(
                      itemCount: tab.children.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => Divider(
                        indent: 16,
                        endIndent: 16,
                        height: 4,
                      ),
                      itemBuilder: (context, index) => tab.children[index],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          if (helper != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child:
                  Text(helper!, style: Theme.of(context).textTheme.bodySmall),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class CustomSplashTabBar extends StatelessWidget
    implements PreferredSizeWidget {
  final TabController controller;
  final List<Widget> tabs;
  final List<double> splashRadii;
  final Color splashColor;
  final Color indicatorColor;
  final double indicatorWeight;

  const CustomSplashTabBar({
    Key? key,
    required this.controller,
    required this.tabs,
    required this.splashRadii,
    this.splashColor = Colors.blueAccent,
    this.indicatorColor = Colors.blue,
    this.indicatorWeight = 2.0,
  })  : assert(tabs.length == splashRadii.length),
        super(key: key);

  @override
  Size get preferredSize => const Size.square(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = controller.index == index;
          return Expanded(
            child: InkResponse(
              onTap: () {
                controller.animateTo(index);
              },
              radius: splashRadii[index],
              splashColor: splashColor.withValues(alpha: 0.3),
              highlightColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? indicatorColor : Colors.transparent,
                      width: indicatorWeight,
                    ),
                  ),
                ),
                child: Center(child: tabs[index]),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/*

Sample

DynamicGroupTabs(
  tabController: useTabController(initialLength: 2),
  padding: const EdgeInsets.symmetric(horizontal: 8),
  header: 'Group',
  tabs: [
    DynamicGroupTabItem(
      title: 'Text',
      children: [
        DynamicGroupItem(
          title: 'Created',
          value:
              (product.created?.toLocal().fullReadable).optional(),
        ),
      ],
    ),
    DynamicGroupTabItem(
      title: 'Text',
      children: [
        DynamicGroupItem(title: 'Sample Value', value: 'Test'),
      ],
    )
  ],
),

*/
