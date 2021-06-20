import 'package:app/models/song.dart';
import 'package:app/ui/widgets/song_thumbnail.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class SongRow extends StatefulWidget {
  final Song song;
  final bool bordered;
  final EdgeInsetsGeometry? padding;

  SongRow({Key? key, required this.song, this.bordered = true, this.padding})
      : super(key: key);

  @override
  _SongRowState createState() => _SongRowState();
}

class _SongRowState extends State<SongRow> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: widget.padding,
      shape: widget.bordered
          ? Border(
              bottom: BorderSide(color: Colors.grey.shade800, width: 0.5),
            )
          : null,
      leading: SongThumbnail(song: widget.song),
      title: Text(widget.song.title, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        widget.song.album.name,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: GestureDetector(
        onTapDown: (TapDownDetails details) => _openContextMenu(
          context,
          details,
          widget.song,
        ),
        child: Icon(
          Icons.more_horiz,
        ),
      ),
    );
  }

  Future<void> _openContextMenu(
    BuildContext context,
    TapDownDetails details,
    Song song,
  ) async {
    await showMenu(
      context: context,
      items: <PopupMenuEntry>[
        PopupMenuItem(
          padding: EdgeInsets.all(0),
          child: ListTile(
            title: Text('Play Now'),
            trailing: Icon(Icons.play_circle_outline),
            onTap: () async {
              AudioService.customAction(
                'playNow',
                (await song.asMediaItem()).id,
              );
            },
          ),
        ),
        PopupMenuItem(
          padding: EdgeInsets.all(0),
          child: ListTile(
            title: Text('Play Next'),
            trailing: Icon(Icons.queue_music),
          ),
        ),
        PopupMenuItem(
          padding: EdgeInsets.all(0),
          child: ListTile(
            title: Text('Add to Queue'),
            trailing: Icon(Icons.queue_music),
            onTap: () async =>
                await AudioService.addQueueItem(await song.asMediaItem()),
          ),
        ),
        PopupMenuItem(
          padding: EdgeInsets.all(0),
          child: ListTile(
            title: Text('Add to a Playlist…'),
            trailing: Icon(Icons.playlist_add),
          ),
        ),
        PopupMenuItem(
          padding: EdgeInsets.all(0),
          child: ListTile(
            title: Text(song.liked ? 'Unlove' : 'Love'),
            trailing: Icon(song.liked ? Icons.favorite : Icons.favorite_border),
          ),
        ),
      ],
      position: RelativeRect.fromLTRB(
          details.globalPosition.dx, details.globalPosition.dy, 20, 16),
    );
  }
}
