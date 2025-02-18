# roc-heck
Case conversion library for Roc, based on the Rust [heck](https://crates.io/crates/heck) crate

[![Roc-Lang][roc_badge]][roc_link]
[![GitHub last commit][last_commit_badge]][last_commit_link]
[![CI status][ci_status_badge]][ci_status_link]
[![Latest release][version_badge]][version_link]


## Examples
```roc
expect to_kebab_case("XMLHttpRequest") == "xml-http-request"
expect to_lower_camel_case("XMLHttpRequest") == "xmlHttpRequest"
expect to_pascal_case("XMLHttpRequest") == "XmlHttpRequest"
expect to_shouty_kebab_case("XMLHttpRequest") == "XML-HTTP-REQUEST"
expect to_shouty_snake_case("XMLHttpRequest") == "XML_HTTP_REQUEST"
expect to_shouty_snek_case("XMLHttpRequest") == "XML_HTTP_REQUEST"
expect to_snake_case("XMLHttpRequest") == "xml_http_request"
expect to_snek_case("XMLHttpRequest") == "xml_http_request"
expect to_title_case("XMLHttpRequest") == "Xml Http Request"
expect to_train_case("XMLHttpRequest") == "Xml-Http-Request"
expect to_upper_camel_case("XMLHttpRequest") == "XmlHttpRequest"
```

<!-- LINKS -->
[roc_badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Fpastebin.com%2Fraw%2FcFzuCCd7
[roc_link]: https://github.com/roc-lang/roc
[ci_status_badge]: https://img.shields.io/github/actions/workflow/status/imclerran/roc-heck/ci.yaml?logo=github&logoColor=lightgrey
[ci_status_link]: https://github.com/imclerran/roc-heck/actions/workflows/ci.yaml
[last_commit_badge]: https://img.shields.io/github/last-commit/imclerran/roc-heck?logo=git&logoColor=lightgrey
[last_commit_link]: https://github.com/imclerran/roc-heck/commits/main/
[version_badge]: https://img.shields.io/github/v/release/imclerran/roc-heck
[version_link]: https://github.com/imclerran/roc-heck/releases/latest
