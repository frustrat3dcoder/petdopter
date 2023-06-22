import 'package:equatable/equatable.dart';

class SliderEntity extends Equatable {
  final String? preHighlightText;
  final String? highlightText;
  final String? postHighlightText;
  final String? imageUrl;

  const SliderEntity({
    this.highlightText,
    this.imageUrl,
    this.postHighlightText,
    this.preHighlightText,
  });

  @override
  List<Object?> get props =>
      [preHighlightText, postHighlightText, highlightText, imageUrl];
}
