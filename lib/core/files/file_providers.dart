import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'file_transfer.dart';

part 'file_providers.g.dart';

@Riverpod(keepAlive: true)
FileTransfer fileTransfer(Ref ref) => const PlatformFileTransfer();
