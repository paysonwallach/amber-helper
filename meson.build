project(
  'com.paysonwallach.amber.helper',
  'vala',
  'c',
  license: 'GPL-3.0',
  meson_version: '>=0.55.0',
  version: '0.1.0'
)

glib_dep = dependency('gtk+-3.0')

executable(
  meson.project_name(),
  'src/Main.vala',
  dependencies: [
    glib_dep
  ],
  install: true
)

subdir('data')

meson.add_install_script('meson/post_install.py')
