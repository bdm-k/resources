import { map, rule, writeToProfile } from 'karabiner.ts'

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
  map('international3').to('grave_accent_and_tilde'),
  map('japanese_pc_nfer').to('japanese_eisuu'),
  map('japanese_pc_xfer').to('japanese_kana'),
]);

writeToProfile(
  // Use '--dry-run' to print the generated JSON to the console
  '--dry-run',
  [
    arrow_key_rule,
    jis_keyboard_rule,
  ]
);
