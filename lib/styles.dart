import 'package:jaspr/dom.dart';

const _orange = Color('#FFB74D');
const _background = Color('#121212');
const _muted = Color.rgba(255, 255, 255, 0.7);
const _divider = Color.rgba(255, 255, 255, 0.38);
const _hover = Color.rgba(255, 255, 255, 0.08);
const _track = Color.rgba(255, 255, 255, 0.15);

@css
List<StyleRule> get styles => [
  css.import('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap'),
  css.keyframes('rexios-spin', {'to': Styles(transform: .rotate(360.deg))}),
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
    maxWidth: 800.px,
    padding: .only(top: 40.px, right: 20.px, bottom: 96.px, left: 20.px),
    margin: .symmetric(horizontal: .auto),
  ),
  css('.page-title').styles(
    margin: .only(bottom: 40.px),
    textAlign: .center,
    fontSize: 28.px,
    fontWeight: .w400,
    lineHeight: 36.px,
  ),
  css('.project-section + .project-section').styles(margin: .only(top: 80.px)),
  css('.section-title').styles(
    margin: .zero,
    textAlign: .center,
    fontSize: 22.px,
    fontWeight: .w400,
    lineHeight: 28.px,
  ),
  css('.section-subtitle').styles(
    margin: .zero,
    color: _muted,
    textAlign: .center,
    fontSize: 12.px,
    lineHeight: 16.px,
  ),
  css('.project-copy').styles(
    margin: .only(top: 20.px),
    fontSize: 14.px,
    lineHeight: 20.px,
  ),
  css('.project-image').styles(
    display: .block,
    height: .auto,
    maxWidth: 100.percent,
    margin: .only(top: 20.px, right: .auto, left: .auto),
  ),
  css('.project-list').styles(margin: .only(top: 20.px)),
  css('.project-card', [
    css('&').styles(
      display: .block,
      padding: .all(10.px),
      margin: .only(bottom: 30.px),
      radius: .all(.circular(8.px)),
      cursor: .pointer,
      color: .inherit,
      textDecoration: .none,
    ),
    css('&:hover').styles(backgroundColor: _hover),
  ]),
  css('.project-card-header').styles(
    display: .flex,
    flexWrap: .wrap,
    justifyContent: .spaceBetween,
    alignItems: .center,
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
  css('.stats-center').styles(
    display: .flex,
    margin: .only(top: 20.px),
    justifyContent: .center,
  ),
  css('.stats').styles(display: .flex, flexWrap: .wrap, alignItems: .stretch),
  css('.stat').styles(display: .flex, flexDirection: .column, alignItems: .center),
  css('.stat + .stat').styles(
    padding: .only(left: 5.px),
    margin: .only(left: 5.px),
    border: .only(
      left: .solid(color: _divider, width: 1.px),
    ),
  ),
  css('.stat-label').styles(
    margin: .only(top: 3.px),
    fontSize: 8.px,
    lineHeight: 10.px,
  ),
  css('.status-text').styles(
    margin: .only(top: 20.px),
    textAlign: .center,
  ),
  css('.spinner').styles(
    display: .block,
    width: 36.px,
    height: 36.px,
    margin: .symmetric(vertical: 24.px, horizontal: .auto),
    border: .all(color: _track, width: 4.px),
    radius: .all(.circular(50.percent)),
    raw: {'border-top-color': '#FF9800', 'animation': 'rexios-spin 0.8s linear infinite'},
  ),
  css('.rendered-with').styles(
    margin: .only(top: 32.px),
    textAlign: .center,
    fontSize: 14.px,
  ),
  css('.contact-bar').styles(
    display: .flex,
    position: .fixed(bottom: 0.px, left: 0.px, right: 0.px),
    zIndex: ZIndex(2),
    padding: .symmetric(vertical: 5.px, horizontal: 10.px),
    radius: .only(topLeft: .circular(20.px), topRight: .circular(20.px)),
    shadow: BoxShadow(offsetX: 0.px, offsetY: (-4).px, blur: 8.px, color: Color.rgba(255, 255, 255, 0.35)),
    justifyContent: .center,
    backgroundColor: Colors.black,
  ),
  css('.social-link', [
    css('&').styles(
      display: .flex,
      width: 40.px,
      height: 40.px,
      cursor: .pointer,
      justifyContent: .center,
      alignItems: .center,
      color: Colors.white,
      textDecoration: .none,
    ),
    css('&:hover').styles(color: _orange),
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
  css.media(.screen(maxWidth: 640.px), [
    css('.project-card-header').styles(flexDirection: .column, alignItems: .start),
  ]),
];
