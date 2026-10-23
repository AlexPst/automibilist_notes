// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fileTransfer)
final fileTransferProvider = FileTransferProvider._();

final class FileTransferProvider
    extends $FunctionalProvider<FileTransfer, FileTransfer, FileTransfer>
    with $Provider<FileTransfer> {
  FileTransferProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fileTransferProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fileTransferHash();

  @$internal
  @override
  $ProviderElement<FileTransfer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FileTransfer create(Ref ref) {
    return fileTransfer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FileTransfer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FileTransfer>(value),
    );
  }
}

String _$fileTransferHash() => r'319a5f00fdd593770cecfd2cfa8cde9d9b0b3dff';
