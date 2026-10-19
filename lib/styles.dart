import 'package:jaspr/dom.dart';

const _orange = Color('#FFB74D');
const _background = Color('#121212');
const _muted = Color.rgba(255, 255, 255, 0.7);
const _divider = Color.rgba(255, 255, 255, 0.38);
const _line = Color.rgba(255, 255, 255, 0.16);
const _hover = Color.rgba(255, 255, 255, 0.08);

@css
List<StyleRule> get styles => [
  css.import('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap'),
  css('*, *::before, *::after').styles(boxSizing: .borderBox),
  css('html, body').styles(
    width: 100.percent,
    minHeight: 100.vh,
    padding: .zero,
    margin: .zero,
    color: Colors.white,
    fontFamily: const .list([FontFamily('Roboto'), FontFamilies.sansSerif]),
    fontSize: 14.px,
    lineHeight: 20.px,
    backgroundColor: _background,
    raw: {'color-scheme': 'dark'},
  ),
  css('h1, h2, p').styles(margin: .zero),
  css('a').styles(color: _orange),
  css('a:visited').styles(color: _orange),
  css('.page').styles(
    width: 100.percent,
    maxWidth: 1040.px,
    padding: .only(top: 40.px, right: 20.px, bottom: 96.px, left: 20.px),
    margin: .symmetric(horizontal: .auto),
    raw: {'padding-bottom': 'calc(96px + env(safe-area-inset-bottom))'},
  ),
  css('.page-title').styles(
    textAlign: .start,
    fontSize: 28.px,
    fontWeight: .w400,
    lineHeight: 36.px,
  ),
  css('.page-intro').styles(
    margin: .only(top: 8.px, bottom: 48.px),
    color: _muted,
  ),
  css('.project-section + .project-section').styles(margin: .only(top: 48.px)),
  css('.section-title').styles(
    margin: .zero,
    textAlign: .start,
    fontSize: 22.px,
    fontWeight: .w400,
    lineHeight: 28.px,
  ),
  css('.section-subtitle').styles(
    margin: .only(top: 4.px),
    color: _muted,
    textAlign: .start,
    fontSize: 12.px,
    lineHeight: 16.px,
  ),
  css('.featured').styles(
    display: .flex,
    flexDirection: .column,
    gap: .all(24.px),
  ),
  css('.featured-body').styles(display: .flex, flexDirection: .column),
  css('.featured-media', [
    css('&, &:visited').styles(
      display: .block,
      border: .all(color: _line, width: 1.px),
      radius: .all(.circular(8.px)),
      overflow: .hidden,
      cursor: .pointer,
      lineHeight: .zero,
    ),
    css('&:hover').styles(
      border: .all(color: _orange, width: 1.px),
    ),
  ]),
  css('.project-copy').styles(
    margin: .only(top: 16.px),
    fontSize: 14.px,
    lineHeight: 20.px,
  ),
  css('.featured-body .stats').styles(margin: .only(top: 16.px)),
  css('.project-image').styles(display: .block, width: 100.percent, height: .auto),
  css('.project-list').styles(
    display: .flex,
    margin: .only(top: 20.px),
    flexDirection: .column,
    gap: .all(12.px),
  ),
  css('.project-card', [
    css('&, &:visited').styles(
      display: .block,
      padding: .all(16.px),
      border: .all(color: _line, width: 1.px),
      radius: .all(.circular(8.px)),
      cursor: .pointer,
      color: .inherit,
      textDecoration: .none,
    ),
    css('&:hover').styles(
      border: .all(color: _divider, width: 1.px),
      backgroundColor: _hover,
    ),
  ]),
  css('.project-card-header').styles(
    display: .flex,
    flexDirection: .column,
    alignItems: .start,
    gap: .all(8.px),
  ),
  css('.project-name').styles(
    fontSize: 14.px,
    fontWeight: .w700,
    raw: {'overflow-wrap': 'anywhere'},
  ),
  css('.project-description').styles(
    margin: .only(top: 10.px),
    fontSize: 14.px,
    lineHeight: 20.px,
  ),
  css('.stats').styles(
    display: .flex,
    flexWrap: .wrap,
    alignItems: .stretch,
    gap: .all(16.px),
  ),
  css('.stat').styles(display: .flex, flexDirection: .column, alignItems: .center),
  css('.stat-value').styles(fontSize: 14.px, fontWeight: .w700, lineHeight: 18.px),
  css('.stat-label').styles(
    margin: .only(top: 2.px),
    color: _muted,
    fontSize: 12.px,
    lineHeight: 16.px,
  ),
  css('.built-with').styles(
    display: .flex,
    margin: .only(top: 32.px),
    justifyContent: .center,
  ),
  css('.built-with a').styles(display: .flex, textDecoration: .none, lineHeight: .zero),
  css('.contact-bar').styles(
    display: .flex,
    position: .fixed(bottom: 0.px, left: 50.percent),
    zIndex: ZIndex(2),
    width: .maxContent,
    padding: .only(top: 5.px, right: 10.px, left: 10.px),
    border: .only(
      top: .solid(color: _line, width: 1.px),
    ),
    radius: .only(topLeft: .circular(20.px), topRight: .circular(20.px)),
    transform: .translate(x: (-50).percent),
    justifyContent: .center,
    backgroundColor: Colors.black,
    raw: {'padding-bottom': 'calc(5px + env(safe-area-inset-bottom))'},
  ),
  css('.social-link', [
    css('&, &:visited').styles(
      display: .flex,
      width: 40.px,
      height: 40.px,
      cursor: .pointer,
      justifyContent: .center,
      alignItems: .center,
      color: Colors.white,
      textDecoration: .none,
    ),
    css('&:hover, &:visited:hover').styles(color: _orange),
  ]),
  css('.brand-icon').styles(display: .block, raw: {'fill': 'currentColor'}),
  css('.visually-hidden').styles(
    position: .absolute(),
    width: 1.px,
    height: 1.px,
    padding: .zero,
    margin: .all((-1).px),
    overflow: .hidden,
    whiteSpace: .noWrap,
    raw: {'clip': 'rect(0, 0, 0, 0)', 'clip-path': 'inset(50%)'},
  ),
  css.media(.screen(minWidth: 840.px), [
    css('.featured').styles(
      flexDirection: .rowReverse,
      alignItems: .center,
      gap: .all(32.px),
    ),
    css('.featured-body').styles(
      minWidth: Unit.zero,
      flex: const Flex(grow: 1, shrink: 1, basis: Unit.zero),
    ),
    css('.featured-media').styles(
      minWidth: Unit.zero,
      flex: const Flex(grow: 1.25, shrink: 1, basis: Unit.zero),
    ),
  ]),
];
