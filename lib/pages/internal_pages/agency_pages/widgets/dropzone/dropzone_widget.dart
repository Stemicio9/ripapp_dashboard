import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/dropzone/file_data_model.dart';

class DropZoneWidget extends StatefulWidget {
  final ValueChanged<File_Data_Model> onDroppedFile;
  final File_Data_Model? file;

  const DropZoneWidget(
      {Key? key, required this.onDroppedFile, required this.file})
      : super(key: key);

  @override
  _DropZoneWidgetState createState() => _DropZoneWidgetState();
}

class _DropZoneWidgetState extends State<DropZoneWidget> {
  late DropzoneViewController controller;
  bool highlight = false;

  @override
  Widget build(BuildContext context) {
    return buildDecoration(
        child: Stack(
      children: [
        // dropzone area
        DropzoneView(
          // attach an configure the controller
          onCreated: (controller) => this.controller = controller,
          // call UploadedFile method when user drop the file
          onDrop: UploadedFile,
          // change UI when user hover file on dropzone
          onHover: () => setState(() => highlight = true),
          onLeave: () => setState(() => highlight = false),
          onLoaded: () => print('Zone Loaded'),
          onError: (err) => print('run when error found : $err'),
        ),

        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.cloud_upload_outlined,
                size: 80,
                color: Colors.white,
              ),
              const Text(
                'Trascina qui un file',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(
                height: 16,
              ),
              // a button to pickfile from computer
              ElevatedButton.icon(
                onPressed: () async {
                  final events = await controller.pickFiles();
                  if (events.isEmpty) return;
                  UploadedFile(events.first);
                },
                icon: const Icon(Icons.search,color: background,),
                label: const Text(
                  'Seleziona file',
                  style: TextStyle(
                    color: background,
                    fontSize: 15,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    primary: white,
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    )),
              ),

              widget.file != null ? buildFileDetail(widget.file) : Container()
            ],
          ),
        ),
      ],
    ));
  }

  Future UploadedFile(dynamic event) async {
    final name = event.name;
    final mime = await controller.getFileMIME(event);
    final byte = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);
    final file = await controller.getFileData(event);

    print('Name : $name');
    print('Mime: $mime');
    print('File: $file');
    print('Size : ${byte / (1024 * 1024)}');
    print('URL: $url');

    // update the data model with recent file uploaded
    final droppedFile = File_Data_Model(
        name: name, mime: mime, bytes: byte, url: url, file: file);

    //Update the UI
    widget.onDroppedFile(droppedFile);

    setState(() {
      highlight = false;
    });
  }

  Widget buildFileDetail(File_Data_Model? file) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            file!.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w800, fontSize: 18, color: white),
          ),
        ),
        Text('Dimensione: ${file.size}',
            style: const TextStyle(fontSize: 16, color: white)),
      ],
    );
  }

  Widget buildDecoration({required Widget child}) {
    final colorBackground = highlight ? background : backgroundWithOpacity;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: colorBackground,
        child: DottedBorder(
            borderType: BorderType.RRect,
            color: Colors.white,
            strokeWidth: 3,
            dashPattern: [8, 4],
            radius: const Radius.circular(10),
            padding: EdgeInsets.zero,
            child: child),
      ),
    );
  }
}
