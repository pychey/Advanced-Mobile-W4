import 'package:flutter/material.dart';
 
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;
 
 // TODO

  Widget _buildIcon() {
    switch (controller.status) {
      case DownloadStatus.notDownloaded:
        return IconButton(
          icon: Icon(Icons.download),
          onPressed: () => controller.startDownload(),
        );
      case DownloadStatus.downloading:
        return IconButton(
          icon: Icon(Icons.downloading),
          onPressed: () {},
        );
      case DownloadStatus.downloaded:
        return IconButton(
          icon: Icon(Icons.folder),
          onPressed: () {},
        );
    }
  }

  Widget _buildSubtitle() {
    if (controller.status == DownloadStatus.notDownloaded) {
      return SizedBox.shrink();
    }
    final progress = (controller.progress * controller.ressource.size).toStringAsFixed(1);
    final percent = (controller.progress * 100).toStringAsFixed(1);
    return Text(
      '$percent % completed - $progress of ${controller.ressource.size} MB',
      style: TextStyle(fontSize: 14, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) => Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.ressource.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                _buildSubtitle(),
              ],
            ),
            _buildIcon(),
          ],
        ),
      ),
    );
  }
}
