import 'package:app/providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ProfileAvatarMenuItems {
  clearDownloads,
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({Key? key}) : super(key: key);

  void clearDownloads(BuildContext context) {
    context.read<DownloadProvider>().clear();
  }

  @override
  Widget build(BuildContext context) {
    context.read<DownloadProvider>();

    return PopupMenuButton<ProfileAvatarMenuItems>(
      onSelected: (item) {
        switch (item) {
          case ProfileAvatarMenuItems.clearDownloads:
            clearDownloads(context);
            break;
        }
      },
      child: const Icon(CupertinoIcons.person_alt_circle, size: 24),
      offset: const Offset(0, 32),
      itemBuilder: (_) => [
        const PopupMenuItem(
          value: ProfileAvatarMenuItems.clearDownloads,
          child: Text('Clear downloads'),
        ),
      ],
    );
  }
}
