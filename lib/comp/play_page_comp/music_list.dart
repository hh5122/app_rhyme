import 'package:app_rhyme/comp/card/music_card.dart';
import 'package:app_rhyme/main.dart';
import 'package:app_rhyme/util/audio_controller.dart';
import 'package:app_rhyme/util/selection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// PlayMusicList组件
class PlayMusicList extends StatelessWidget {
  final double maxHeight;
  final EdgeInsets picPadding;
  final double itemHeight;
  const PlayMusicList(
      {super.key,
      required this.maxHeight,
      required this.picPadding,
      this.itemHeight = 50});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var musics = globalAudioHandler.playMusicList;

      return Container(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: CupertinoColors.systemGrey,
                  indent: 50,
                  endIndent: 50,
                ),
                itemBuilder: (context, index) => MusicCard(
                  height: itemHeight,
                  showQualityBackGround: false,
                  padding: Padding(padding: picPadding),
                  key: ValueKey((musics[index].info.name +
                          musics[index].info.source +
                          musics[index].info.name)
                      .hashCode),
                  music: musics[index],
                  onClick: () {
                    globalAudioHandler.seek(Duration.zero, index: index);
                  },
                  onPress: () {
                    showCupertinoPopupWithActions(context: context, options: [
                      "删除",
                      "添加"
                    ], actionCallbacks: [
                      () async {
                        globalAudioHandler.removeAt(index);
                      },
                      () async {
                        var tables =
                            await globalSqlMusicFactory.readMusicLists();
                        var tableNames = tables.map((e) => e.name).toList();
                        if (context.mounted) {
                          showCupertinoPopupWithSameAction(
                              context: context,
                              options: tableNames,
                              actionCallbacks: (index_) async {
                                await globalSqlMusicFactory.insertMusic(
                                    musicList: tables[index_],
                                    musics: [musics[index].ref]);
                              });
                        }
                      }
                    ]);
                  },
                ),
                itemCount: musics.length,
              ),
            ],
          ));
    });
  }
}