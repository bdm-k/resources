import {
  writeToProfile,
  rule,
  layer,
  map,
  ifApp,
  withCondition,
  ifDevice,
} from 'karabiner.ts';


const APPLE_INTERNAL_KEYBOARD = { is_built_in_keyboard: true };
const KEYCHRON_K3_MAX = { vendor_id: 13364, product_id: 2613 };

// NOTE: Spacebar also triggers aerospace-mode
const APP_SWITCHER_BIN =
  '~/resources/app_switcher/_build/default/bin/main.exe';
const AppSwitchRule = layer(
  'spacebar', 'app-switch-mode'
).manipulators([
  map('f').to$(`${APP_SWITCHER_BIN} 'WezTerm'`),
  map('v').to$(`${APP_SWITCHER_BIN} 'Visual Studio Code'`),
  map('b').to$(`${APP_SWITCHER_BIN} 'Brave Browser'`),
  map(';').to$(`${APP_SWITCHER_BIN} 'Obsidian'`),
  map('g').to$(`${APP_SWITCHER_BIN} 'Dictionary'`),
  map('d').to$(`${APP_SWITCHER_BIN} 'Slack'`),
  map('r').to$(`${APP_SWITCHER_BIN} 'Structured'`),
]);

// NOTE: Spacebar also triggers open-app-mode
const AEROSPACE_BIN = '/opt/homebrew/bin/aerospace';
const AerospaceRule = layer(
  'spacebar', 'aerospace-mode'
).manipulators([
  // Rarely used key bindings are defined in the AeroSpace config

  // navigate windows
  map('h').to$(`${AEROSPACE_BIN} focus left`),
  map('j').to$(`${AEROSPACE_BIN} focus down`),
  map('k').to$(`${AEROSPACE_BIN} focus up`),
  map('l').to$(`${AEROSPACE_BIN} focus right`),

  // navigate workspaces
  map('u').to$(`${AEROSPACE_BIN} workspace main`),
  map('i').to$(`${AEROSPACE_BIN} workspace sub`),
  map('o').to$(`${AEROSPACE_BIN} workspace comm.`),

  // resize
  map('-').to$(`${AEROSPACE_BIN} resize smart -50`),
  map('=').to$(`${AEROSPACE_BIN} resize smart +50`),

  // change layout
  map('/').to$(`${AEROSPACE_BIN} layout tiles horizontal vertical`),
  map(',').to$(`${AEROSPACE_BIN} layout accordion horizontal vertical`),
  map('e').to$(`${AEROSPACE_BIN} macos-native-fullscreen`),

  // move windows
  map('left_arrow').to$(`${AEROSPACE_BIN} move left`),
  map('right_arrow').to$(`${AEROSPACE_BIN} move right`),
  withCondition(ifDevice(APPLE_INTERNAL_KEYBOARD))([
    map('down_arrow').to$(`${AEROSPACE_BIN} move down`),
    map('up_arrow').to$(`${AEROSPACE_BIN} move up`),
  ]),
  withCondition(ifDevice(KEYCHRON_K3_MAX))([
    map('up_arrow').to$(`${AEROSPACE_BIN} move down`),
    map('down_arrow').to$(`${AEROSPACE_BIN} move up`),
  ]),

  // move windows to different workspaces
  map('4').to$(`${AEROSPACE_BIN} move-node-to-workspace main`),
  map('5').to$(`${AEROSPACE_BIN} move-node-to-workspace sub`),
  map('6').to$(`${AEROSPACE_BIN} move-node-to-workspace comm.`),
]);

const JISKeyboardRule = rule(
  'Physical JIS keyboard with ANSI layout'
).manipulators([
  map('international1').to('right_control'),
  map('japanese_pc_nfer').to('japanese_eisuu'),
  map('japanese_pc_xfer').to('japanese_kana'),

  withCondition(ifDevice(APPLE_INTERNAL_KEYBOARD))([
    map('international3', 'optionalAny').to('grave_accent_and_tilde'),
  ]),

  // Adapt the order of arrow keys to Vim style
  withCondition(ifDevice(KEYCHRON_K3_MAX))([
    map('up_arrow', 'optionalAny').to('down_arrow'),
    map('down_arrow', 'optionalAny').to('up_arrow'),
  ]),
]);

const AlternativeEscBackspaceRule = rule(
  'Alternative keybindings for Esc, Backspace, and Enter'
).manipulators([
  withCondition(ifDevice(APPLE_INTERNAL_KEYBOARD))([
    map('left_control').to('left_control').toIfAlone('escape'),
  ]),
  withCondition(ifDevice(KEYCHRON_K3_MAX))([
    map('caps_lock').to('left_control').toIfAlone('escape'),
  ]),

  map('n', 'left_control' ).to('delete_or_backspace'),
  map('m', 'left_control').to('return_or_enter'),
]);

const ArrowKeyRule = rule(
  'Left control + hjkl to arrow keys'
).manipulators([
  map('h', 'left_control', 'any').to('left_arrow'),
  map('j', 'left_control', 'any').to('down_arrow'),
  map('k', 'left_control', 'any').to('up_arrow'),
  map('l', 'left_control', 'any').to('right_arrow'),
]);

const OriginalLayoutRule = rule(
  'My original keyboard layout based on colemak'
).manipulators([
  map('d', 'optionalAny').to('s'),
  map('e', 'optionalAny').to('f'),
  map('f', 'optionalAny').to('t'),
  map('g', 'optionalAny').to('d'),
  map('i', 'optionalAny').to('u'),
  map('j', 'optionalAny').to('n'),
  map('k', 'optionalAny').to('e'),
  map('l', 'optionalAny').to('i'),
  map('n', 'optionalAny').to('k'),
  map('o', 'optionalAny').to('g'),
  map('p', 'optionalAny').to('y'),
  map('r', 'optionalAny').to('p'),
  map('s', 'optionalAny').to('r'),
  map('t', 'optionalAny').to(';'),
  map('u', 'optionalAny').to('l'),
  map('y', 'optionalAny').to('j'),
  map(';', 'optionalAny').to('o'),
]);

const BraveRule = rule(
  'Keyboard shortcuts in Brave Browser',
  ifApp('com.brave.Browser'),
).manipulators([
  // Open previous/next tab
  map('[', 'right_command').to('left_arrow', ['left_command', 'left_option']),
  map(']', 'right_command').to('right_arrow', ['left_command', 'left_option']),

  // Go back/forward
  map('-', 'left_control').to('[', 'left_command'),
  map('=', 'left_control').to(']', 'left_command'),
]);


writeToProfile(
  // Use '--dry-run' to print the generated JSON to the console
  // '--dry-run',
  'Default',
  [
    AppSwitchRule,
    AerospaceRule,
    JISKeyboardRule,
    AlternativeEscBackspaceRule,
    ArrowKeyRule,
    OriginalLayoutRule,
    BraveRule,
  ]
);
