import 'package:boilerplate/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AvatarSize {
  small(30),
  medium(45),
  large(60);

  final double size;
  const AvatarSize(this.size);
}

class Avatar extends StatelessWidget {
  const Avatar({super.key, this.size = AvatarSize.small});

  final AvatarSize size;

  @override
  Widget build(BuildContext context) {
    const avatarSvg = '''
<svg xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:cc="http://creativecommons.org/ns#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="none"><metadata><rdf:RDF><cc:Work><dc:format>image/svg+xml</dc:format><dc:type rdf:resource="http://purl.org/dc/dcmitype/StillImage"/><dc:title>Pixel Art</dc:title><dc:creator><cc:Agent><dc:title>Plastic Jam</dc:title></cc:Agent></dc:creator><cc:license rdf:resource="https://github.com/dicebear/dicebear/blob/main/packages/%40dicebear/pixel-art/LICENSE"/></cc:Work></rdf:RDF></metadata><mask id="avatarsRadiusMask"><rect width="20" height="20" rx="0" ry="0" x="0" y="0" fill="#fff"/></mask><g mask="url(#avatarsRadiusMask)"><path d="M6 4V3h8v1h1v1h1v3h1v3h-1v2h-1v1h-1v1h-2v1h4v1h1v3H3v-3h1v-1h4v-1H6v-1H5v-1H4v-2H3V8h1V5h1V4h1Z" fill="rgba(234, 195, 147, 1)"/><path d="M6 3v1H5v1H4v3H3v3h1v2h1v1h1v1h8v-1h1v-1h1v-2h1V8h-1V5h-1V4h-1V3H6Z" fill="#fff" fill-opacity=".1"/><g/><g><g fill-rule="evenodd" clip-rule="evenodd"><path d="M6 7h1v2H5V8h1V7Zm7 0h1v2h-2V8h1V7Z" fill="#fff"/><path d="M7 7v1H6v1h2V7H7Zm7 0v1h-1v1h2V7h-1Z" fill="#000"/><path d="M7 7v1h1V7H7ZM6 8v1h1V8H6Zm8-1v1h1V7h-1Zm-1 1v1h1V8h-1Z" fill="#fff" fill-opacity=".5"/></g></g><g><g fill-rule="evenodd" clip-rule="evenodd"><path d="M4 7V6h1V5h1v1H5v1H4Zm10-2h1v1h1v1h-1V6h-1V5Z" fill="rgba(78, 26, 19, 1)"/><path d="M4 7V6h1V5h1v1H5v1H4Zm10-2h1v1h1v1h-1V6h-1V5Z" fill="#000" fill-opacity=".1"/></g></g><g><path d="M9 13v1h1v-1H9Z" fill="rgba(210, 153, 133, 1)"/></g><g><path fill-rule="evenodd" clip-rule="evenodd" d="M2 5v1h1v1h2V5h1V3H4v1H3v1H2Zm6-1h2v1h2V4h1V3H8v1Zm6 1h1v2h2V6h1V5h-1V4h-1V3h-2v2Z" fill="rgba(78, 26, 19, 1)"/></g><g/><g/><g/><g><path d="M3 20v-3h1v-1h3v1h1v1h1v1h2v-1h1v-1h1v-1h3v1h1v3H3Z" fill="rgba(91, 192, 222, 1)"/></g></g></svg>
''';

    final parser = SvgPicture.string(
      avatarSvg,
      color: Colors.white,
      fit: BoxFit.fill,
      width: 15,
      height: 15,
    );

    return Container(
      constraints: BoxConstraints(
        maxWidth: size.size,
        maxHeight: size.size,
      ),
      padding: EdgeInsets.all(ThemePadding.medium.padding),
      decoration: BoxDecoration(
        color: ColorPalette.primary.color,
        borderRadius: BorderRadius.circular(ThemeRadius.medium.radius),
      ),
      child: parser,
    );
  }
}
