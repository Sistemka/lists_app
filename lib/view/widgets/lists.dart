import 'package:flutter/material.dart';
import 'package:lists_app/api/lists.dart';
import 'package:lists_app/api/models/response/tags.dart';
import '../../api/models/response/lists.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';
import '../constants/settings.dart';

class IconWithData extends StatelessWidget {
  const IconWithData({
    required this.icon,
    required this.data,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final int data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Container(width: 5),
          Text(data.toString()),
        ],
      ),
    );
  }
}

class ListPreviewBottom extends StatelessWidget {
  const ListPreviewBottom({
    required this.icons,
    Key? key,
  }) : super(key: key);

  final List<IconWithData> icons;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: icons
          .map(
            (iconData) => Flexible(child: iconData),
          )
          .toList(),
    );
  }
}

class Tag extends StatelessWidget {
  const Tag({
    required this.name,
    required this.type,
    Key? key,
  }) : super(key: key);

  final String name;
  final TagType type;

  @override
  Widget build(BuildContext context) {
    Color tagColor = getTagColor(type.name, name);
    IconData? tagIcon;
    switch (type) {
      case TagType.tag:
        tagIcon = null;
        break;
      case TagType.geo_tag:
        tagIcon = Icons.location_on;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: tagColor,
          width: 1.5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        children: [
          ...(tagIcon != null
              ? [
                  Container(
                    margin: const EdgeInsets.only(right: 3),
                    child: Icon(
                      tagIcon,
                      color: tagColor,
                      size: 15,
                    ),
                  ),
                ]
              : []),
          Text(
            name,
            style: TextStyle(
              fontSize: 15,
              color: tagColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class TagBar extends StatelessWidget {
  const TagBar({
    required this.tags,
    Key? key,
  }) : super(key: key);

  final List<Tag> tags;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 30,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: tags,
        ),
      ),
    );
  }
}

class ListPreviewItem extends StatelessWidget {
  const ListPreviewItem({
    required this.listPreview,
    Key? key,
  }) : super(key: key);
  final Preview listPreview;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          children: [
            Row(
              children: [
                (listPreview.user.profilePicture == null
                    ? CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            getAvatarColor(listPreview.user.name.hashCode),
                        child: Text(listPreview.user.name![0].toUpperCase()),
                      )
                    : CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            NetworkImage(listPreview.user.profilePicture!),
                      )),
                Container(
                  width: 10,
                ),
                Text(
                  listPreview.user.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Container(
                  width: 10,
                ),
                Text(
                  DateFormat("HH:mm dd/mm")
                      .format(listPreview.list.publishedAt),
                  style: const TextStyle(decorationThickness: 1),
                ) // TODO: Do not prepare data here
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  listPreview.list.header,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                  // style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            TagBar(
              tags: listPreview.tags
                  .map((tag) => Tag(name: tag.name, type: tag.type))
                  .toList(),
            ),
            ListPreviewBottom(
              icons: [
                IconWithData(
                  icon: Icons.favorite_outline,
                  data: listPreview.list.rating,
                ),
                IconWithData(
                  icon: Icons.remove_red_eye_outlined,
                  data: listPreview.list.views,
                ),
                // IconWithData(
                //   icon: Icons.bookmark_outline,
                //   data: listPreview.list.views,
                // ),
                IconWithData(
                  icon: Icons.comment_outlined,
                  data: listPreview.list.rating,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListsPreview extends StatefulWidget {
  const ListsPreview({Key? key}) : super(key: key);

  @override
  State<ListsPreview> createState() => _ListsPreviewState();
}

class _ListsPreviewState extends State<ListsPreview> {
  final ScrollController _scrollController = ScrollController();
  int _offset = 0;
  final int _size = loadSize;
  DateTime _timeStamp = DateTime.now();
  final List<Preview> _data = [];
  bool _isLoading = false;
  bool _allLoaded = false;

  Future fetch() async {
    if (_isLoading) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    List<Preview> _fetchedData =
        await getListsHandler(_offset, _size, _timeStamp);
    setState(() {
      _offset += _size;
      _data.addAll(_fetchedData);
      if (_fetchedData.isEmpty || _fetchedData.length < _size) {
        _allLoaded = true;
      }
      _isLoading = false;
    });
  }

  Future refresh() async {
    setState(() {
      _timeStamp = DateTime.now();
      _offset = 0;
      _data.clear();
    });
    await fetch();
  }

  @override
  void initState() {
    super.initState();
    refresh();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        fetch();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) {
          if (index < _data.length) {
            return ListPreviewItem(
              listPreview: _data[index],
            );
          } else {
            if (_allLoaded) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "No more lists",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          }
        },
        itemCount: _data.length + 1,
      ),
    );
  }
}

///////////////////////////////////////////////////
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.rating,
    required this.author,
    this.isExpanded = false,
  });

  String expandedValue;
  String author;
  int rating;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
      author: "Noname",
      rating: 100,
    );
  });
}

class ListOfLists extends StatefulWidget {
  const ListOfLists({Key? key}) : super(key: key);

  @override
  State<ListOfLists> createState() => _ListOfListsState();
}

class _ListOfListsState extends State<ListOfLists> {
  final List<Item> _data = generateItems(30);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
