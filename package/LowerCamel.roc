module [with_word, boundary]

import Utils exposing [capitalize, lowercase]

with_word : List (List U8), List U8, Bool -> List (List U8)
with_word = |words, word, first_word|
    if !first_word then List.append(words, capitalize(word)) else List.append(words, lowercase(word))

boundary : List (List U8) -> List (List U8)
boundary = |words| words