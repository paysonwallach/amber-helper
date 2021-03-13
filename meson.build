project(
  'com.paysonwallach.amber.helper',
  'vala',
  'c',
  license: 'GPL-3.0',
  meson_version: '>=0.55.0',
  version: '0.2.0'
)

vala = meson.get_compiler('vala')

vapi_dir = join_paths(meson.source_root(), 'vapi')

glib_dep = dependency('gtk+-3.0')

conf = configuration_data()
conf.set_quoted('APP_ID', meson.project_name())
conf.set_quoted('BRIDGE_DBUS_SERVICE_NAME', 'com.paysonwallach.amber.bridge')
conf.set_quoted('BRIDGE_DBUS_OBJECT_PATH', '/com/paysonwallach/amber/bridge')

config_h = configure_file(
  output: 'config.h',
  configuration: conf
)

config_dep = declare_dependency(
  dependencies: vala.find_library('config', dirs: vapi_dir),
  sources: config_h
)

add_project_arguments(
  ['-DG_LOG_DOMAIN="@0@"'.format(meson.project_name())],
  language:'c'
)

executable(
  meson.project_name(),
  'src/Main.vala',
  dependencies: [
    config_dep,
    glib_dep
  ],
  install: true
)

subdir('data')

meson.add_install_script('meson/post_install.py')
