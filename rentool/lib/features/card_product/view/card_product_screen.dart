import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/card_product/widgets/widgets.dart';

@RoutePage()
class CardProductScreen extends StatefulWidget {
  const CardProductScreen({super.key, required this.tool});

  final Tool tool;

  @override
  State<CardProductScreen> createState() => _CardProductScreenState();
}

class _CardProductScreenState extends State<CardProductScreen> {
  late ValueNotifier<bool> showFullDescription;
  late ValueNotifier<int> counter;

  @override
  void initState() {
    showFullDescription = ValueNotifier<bool>(false);
    counter = ValueNotifier<int>(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<String> lines = widget.tool.description.split(';');
    lines.removeLast();
    return CustomScrollView(
      slivers: <Widget>[
        const SearchAppBar(
          buttonBack: true,
          favoriteIcon: true,
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ImageView(tool: widget.tool),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        TitleName(tool: widget.tool),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _buildParametersList(lines, showFullDescription, theme),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: <Widget>[
                Container(
                  width: 160,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: theme.primaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () => setState(() {
                                counter.value == 1
                                    ? debugPrint('countet >= 1!')
                                    : counter.value--;
                              }),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 18.5),
                            child: Icon(Icons.remove),
                          )),
                      Text('${counter.value}'),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              counter.value == widget.tool.count
                                  ? debugPrint(
                                      'countet >= ${widget.tool.count}')
                                  : counter.value++;
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 18.5),
                            child: Icon(Icons.add),
                          )),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 160,
                  child: ButtonPrimary(
                    text: 'В корзину',
                    onPressed: () {},
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildParametersList(List<String> lines,
      ValueNotifier<bool> showFullDescription, ThemeData theme) {
    return Column(
      children: [
        for (final line
            in lines.sublist(0, showFullDescription.value ? lines.length : 6))
          _parseDataLine(line, theme),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showFullDescription.value = !showFullDescription.value;
                });
              },
              child: showFullDescription.value
                  ? Row(
                      children: [
                        Text(
                          'Свернуть параметры',
                          style: theme.textTheme.bodySmall,
                        ),
                        const Icon(
                          Icons.expand_less_outlined,
                          color: Colors.black,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Text(
                          'Все параметры',
                          style: theme.textTheme.bodySmall,
                        ),
                        const Icon(
                          Icons.expand_more_outlined,
                          color: Colors.black,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _parseDataLine(String line, ThemeData theme) {
    final List<String> parts = line.split('-');
    final List<Widget> rowChildren = [];

    for (final part in parts) {
      final textWidget = Text(
        part,
        style: theme.textTheme.labelMedium,
      );

      if (parts.indexOf(part) < parts.length - 1) {
        rowChildren.add(textWidget);
        rowChildren.add(const Spacer());
      } else {
        rowChildren.add(textWidget);
      }
    }

    return Row(children: rowChildren);
  }
}
