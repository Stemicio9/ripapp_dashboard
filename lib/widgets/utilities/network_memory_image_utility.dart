


import 'dart:typed_data';

import 'package:flutter/material.dart';



class NetworkMemoryImageUtility {

  final bool isNetwork;
  final String networkUrl;
  final Uint8List? memoryImage;


  const NetworkMemoryImageUtility({Key? key,
    this.isNetwork = true,
    this.networkUrl = "",
    this.memoryImage});

  ImageProvider provide() {
      if(isNetwork) {
        return NetworkImage(networkUrl);
      } else {
        return MemoryImage(memoryImage!);
      }
  }
}
