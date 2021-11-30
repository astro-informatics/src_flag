#ifndef FLAG_VERSION_H
#define FLAG_VERSION_H
inline const char *flag_version_string() { return "@PROJECT_VERSION@"; }
inline const char *flag_info() {
  return "package:\n"
         "  name: FLAG\n"
         "  description: Fast Fourier-Laguerre transform on the ball\n"
         "  authors:\n"
         "      - Boris Leistedt\n"
         "      - Jason McEwen\n"
         "      - Matthew Price\n"
         "  license: GPL-3\n"
         "  url: https://github.com/astro-informatics/src_flag\n"
         "  version: @PROJECT_VERSION@\n";
};
// clang-format off
inline int flag_version_major() { return @PROJECT_VERSION_MAJOR@; }
inline int flag_version_minor() { return @PROJECT_VERSION_MINOR@; }
inline int flag_version_patch() { return @PROJECT_VERSION_PATCH@; }
#define FLAG_VERSION_MAJOR  @PROJECT_VERSION_MAJOR@
#define FLAG_VERSION_MINOR  @PROJECT_VERSION_MINOR@
#define FLAG_VERSION_PATCH  @PROJECT_VERSION_PATCH@
// clang-format on
#endif
