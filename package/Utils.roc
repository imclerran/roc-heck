module [is_alphanumeric, is_lowercase, is_uppercase, is_numeric, capitalize, uppercase, lowercase]

is_alphanumeric = |c| is_lowercase(c) or is_uppercase(c) or is_numeric(c)

is_lowercase = |c| c >= 'a' and c <= 'z'

is_uppercase = |c| c >= 'A' and c <= 'Z'

is_numeric = |c| c >= '0' and c <= '9'

capitalize : List U8 -> List U8
capitalize = |word|
    when word is
        [first, .. as rest] ->
            if is_lowercase(first) then
                List.join([[first - 32], lowercase(rest)])
            else
                List.join([[first], lowercase(rest)])

        [] -> []

uppercase : List U8 -> List U8
uppercase = |word|
    when word is
        [first, .. as rest] ->
            if is_lowercase(first) then
                List.join([[first - 32], uppercase(rest)])
            else
                List.join([[first], uppercase(rest)])

        [] -> []

lowercase : List U8 -> List U8
lowercase = |word|
    when word is
        [first, .. as rest] ->
            if first >= 'A' and first <= 'Z' then
                List.join([[first + 32], lowercase(rest)])
            else
                List.join([[first], lowercase(rest)])

        [] -> []
