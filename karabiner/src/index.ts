import {
  writeToProfile,
  rule,
  layer,
  map,
  ifApp,
} from 'karabiner.ts';


const basic_rule = rule(
  'Alternative keybindings for Esc and Backspace'
).manipulators([
  map('return_or_enter', 'left_control').to('escape'),
  map(';', 'left_control').to('delete_or_backspace'),
]);

const arrow_key_rule = rule(
  'Left ctrl + hjkl to arrow keys'
).manipulators([
  map('h', 'left_control', 'any').to('left_arrow'),
  map('j', 'left_control', 'any').to('down_arrow'),
  map('k', 'left_control', 'any').to('up_arrow'),
  map('l', 'left_control', 'any').to('right_arrow'),
]);

const jis_keyboard_rule = rule(
  'Physical JIS keyboard with ANSI layout'
).manipulators([
  map('international1').to('right_control'),
  map('international3', { optional: 'any' }).to('grave_accent_and_tilde'),
  map('japanese_pc_nfer').to('japanese_eisuu'),
  map('japanese_pc_xfer').to('japanese_kana'),
]);

// NOTE: Spacebar also triggers aerospace-mode
const app_switcher_bin =
  '~/resources/app_switcher/_build/default/bin/main.exe';
const open_app_rule = layer(
  'spacebar', 'open-app-mode'
).manipulators([
  map('w').to$(`${app_switcher_bin} 'WezTerm'`),
  map('v').to$(`${app_switcher_bin} 'Visual Studio Code'`),
  map('b').to$(`${app_switcher_bin} 'Brave Browser'`),
  map('o').to$(`${app_switcher_bin} 'Obsidian'`),
  map('g').to$(`${app_switcher_bin} 'ChatGPT'`),
  map('d').to$(`${app_switcher_bin} 'Dictionary'`),
]);

// NOTE: Spacebar also triggers open-app-mode
const aerospace_bin = '/opt/homebrew/bin/aerospace';
const aerospace_rule = layer(
  'spacebar', 'aerospace-mode'
).manipulators([
  // Rarely used key bindings are defined in the AeroSpace config

  // navigate windows
  map('h').to$(`${aerospace_bin} focus left`),
  map('j').to$(`${aerospace_bin} focus down`),
  map('k').to$(`${aerospace_bin} focus up`),
  map('l').to$(`${aerospace_bin} focus right`),

  // navigate workspaces
  map('1').to$(`${aerospace_bin} workspace main`),
  map('2').to$(`${aerospace_bin} workspace sub`),
  map('3').to$(`${aerospace_bin} workspace comm.`),

  // resize
  map('-').to$(`${aerospace_bin} resize smart -50`),
  map('=').to$(`${aerospace_bin} resize smart +50`),

  // change layout
  map('/').to$(`${aerospace_bin} layout tiles horizontal vertical`),
  map(',').to$(`${aerospace_bin} layout accordion horizontal vertical`),

  // move windows
  map('left_arrow').to$(`${aerospace_bin} move left`),
  map('down_arrow').to$(`${aerospace_bin} move down`),
  map('up_arrow').to$(`${aerospace_bin} move up`),
  map('right_arrow').to$(`${aerospace_bin} move right`),

  // move windows to different workspaces
  map('4').to$(`${aerospace_bin} move-node-to-workspace main`),
  map('5').to$(`${aerospace_bin} move-node-to-workspace sub`),
  map('6').to$(`${aerospace_bin} move-node-to-workspace comm.`),
]);

const brave_rule = rule(
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

const layout_rule = rule(
  'My original keyboard layout based on colemak'
).manipulators([
  map('d', { optional: 'right_shift' }).to('s'),
  map('e', { optional: 'right_shift' }).to('f'),
  map('f', { optional: 'right_shift' }).to('t'),
  map('g', { optional: 'right_shift' }).to('d'),
  map('i', { optional: 'left_shift' }).to('u'),
  map('j', { optional: 'left_shift' }).to('n'),
  map('k', { optional: 'left_shift' }).to('e'),
  map('l', { optional: 'left_shift' }).to('i'),
  map('n', { optional: 'left_shift' }).to('k'),
  map('o', { optional: 'left_shift' }).to('g'),
  map('p', { optional: 'left_shift' }).to('y'),
  map('r', { optional: 'right_shift' }).to('p'),
  map('s', { optional: 'right_shift' }).to('r'),
  map('t', { optional: 'right_shift' }).to('semicolon'),
  map('u', { optional: 'left_shift' }).to('l'),
  map('y', { optional: 'left_shift' }).to('j'),
  map('semicolon', { optional: 'left_shift' }).to('o'),
]);


writeToProfile(
  // Use '--dry-run' to print the generated JSON to the console
  'Default',
  [
    basic_rule,
    arrow_key_rule,
    jis_keyboard_rule,
    open_app_rule,
    aerospace_rule,
    brave_rule,
    layout_rule,
  ]
);
