import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sample2/ebookmodule/components/book_list_item.dart';
import 'package:sample2/ebookmodule/components/description_text.dart';
import 'package:sample2/ebookmodule/components/loading_widget.dart';
import 'package:sample2/ebookmodule/database/locator_helper.dart';
import 'package:sample2/ebookmodule/models/category.dart';
import 'package:sample2/ebookmodule/view_models/details_provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class Details extends StatefulWidget {
  final Entry entry;
  final String imgTag;
  final String titleTag;
  final String authorTag;

  const Details({
    Key? key,
    required this.entry,
    required this.imgTag,
    required this.titleTag,
    required this.authorTag,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback(
      (_) {
        Provider.of<DetailsProvider>(context, listen: false)
            .setEntry(widget.entry);
        Provider.of<DetailsProvider>(context, listen: false)
            .getFeed(widget.entry.author!.uri!.t!.replaceAll(r'\&lang=en', ''));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailsProvider>(
      builder: (BuildContext context, DetailsProvider detailsProvider,
          Widget? child) {
        return Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                onPressed: () async {
                  if (detailsProvider.faved) {
                    detailsProvider.removeFav();
                  } else {
                    detailsProvider.addFav();
                  }
                },
                icon: Icon(
                  detailsProvider.faved ? Icons.favorite : Feather.heart,
                  color: detailsProvider.faved
                      ? Colors.red
                      : Theme.of(context).iconTheme.color,
                ),
              ),
              IconButton(
                onPressed: () => _share(),
                icon: const Icon(
                  Feather.share,
                ),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            children: <Widget>[
              const SizedBox(height: 10.0),
              _buildImageTitleSection(detailsProvider),
              const SizedBox(height: 30.0),
              _buildSectionTitle('Book Description'),
              _buildDivider(),
              const SizedBox(height: 10.0),
              DescriptionTextWidget(
                text: '${widget.entry.summary!.t}',
              ),
              const SizedBox(height: 30.0),
              _buildSectionTitle('More from Author'),
              _buildDivider(),
              const SizedBox(height: 10.0),
              _buildMoreBook(detailsProvider),
            ],
          ),
        );
      },
    );
  }

  _buildDivider() {
    return Divider(
      color: Theme.of(context).textTheme.caption!.color,
    );
  }

  _buildImageTitleSection(DetailsProvider detailsProvider) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: widget.imgTag,
            child: CachedNetworkImage(
              imageUrl: '${widget.entry.link![1].href}',
              placeholder: (context, url) => Container(
                height: 200.0,
                width: 130.0,
                child: const LoadingWidget(),
              ),
              errorWidget: (context, url, error) => const Icon(Feather.x),
              fit: BoxFit.cover,
              height: 200.0,
              width: 130.0,
            ),
          ),
          const SizedBox(width: 20.0),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 5.0),
                Hero(
                  tag: widget.titleTag,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      '${widget.entry.title!.t!.replaceAll(r'\', '')}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                Hero(
                  tag: widget.authorTag,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      '${widget.entry.author!.name!.t}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                _buildCategory(widget.entry, context),
                Center(
                  child: Container(
                    height: 20.0,
                    width: MediaQuery.of(context).size.width,
                    child: _buildDownloadReadButton(detailsProvider, context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildSectionTitle(String title) {
    return Text(
      '$title',
      style: TextStyle(
        color: Theme.of(context).accentColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _buildMoreBook(DetailsProvider provider) {
    if (provider.loading) {
      return Container(
        height: 100.0,
        child: const LoadingWidget(),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: provider.related.feed!.entry!.length,
        itemBuilder: (BuildContext context, int index) {
          Entry entry = provider.related.feed!.entry![index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: BookListItem(
              entry: entry,
            ),
          );
        },
      );
    }
  }

  openBook(DetailsProvider provider) async {
    List dlList = await provider.getDownload();
    if (dlList.isNotEmpty) {
      // dlList is a list of the downloads relating to this Book's id.
      // The list will only contain one item since we can only
      // download a book once. Then we use `dlList[0]` to choose the
      // first value from the string as out local book path
      Map dl = dlList[0];
      String path = dl['path'];

      List locators =
          await LocatorDB().getLocator(widget.entry.id!.t!.toString());

      EpubViewer.setConfig(
        identifier: 'androidBook',
        themeColor: Theme.of(context).accentColor,
        scrollDirection: EpubScrollDirection.VERTICAL,
        enableTts: false,
        allowSharing: true,
      );
      EpubViewer.open(path,
          lastLocation:
              locators.isNotEmpty ? EpubLocator.fromJson(locators[0]) : null);
      EpubViewer.locatorStream.listen((event) async {
        // Get locator here
        Map json = jsonDecode(event);
        json['bookId'] = widget.entry.id!.t!.toString();
        // Save locator to your database
        await LocatorDB().update(json);
      });
    }
  }

  _buildDownloadReadButton(DetailsProvider provider, BuildContext context) {
    if (provider.downloaded) {
      return FlatButton(
        onPressed: () => openBook(provider),
        child: const Text(
          'Read Book',
        ),
      );
    } else {
      return FlatButton(
        onPressed: () => provider.downloadFile(
          context,
          widget.entry.link![3].href!,
          widget.entry.title!.t!.replaceAll(' ', '_').replaceAll(r"\'", "'"),
        ),
        child: const Text(
          'Download',
        ),
      );
    }
  }

  _buildCategory(Entry entry, BuildContext context) {
    if (entry.category == null) {
      return const SizedBox();
    } else {
      return Container(
        height: entry.category!.length < 3 ? 55.0 : 95.0,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: entry.category!.length > 4 ? 4 : entry.category!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 210 / 80,
          ),
          itemBuilder: (BuildContext context, int index) {
            Category cat = entry.category![index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border: Border.all(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                      '${cat.label}',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: cat.label!.length > 18 ? 6.0 : 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  _share() {
    Share.share('${widget.entry.title!.t} by ${widget.entry.author!.name!.t}'
        'Read/Download ${widget.entry.title!.t} from ${widget.entry.link![3].href}.');
  }
}
