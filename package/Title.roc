module [with_word, boundary]

import Utils exposing [capitalize]

with_word : List (List U8), List U8, Bool -> List (List U8)
with_word = |words, word, _first_word| List.append(words, capitalize(word))

boundary : List (List U8) -> List (List U8)
boundary = |words| List.append(words, [' '])
