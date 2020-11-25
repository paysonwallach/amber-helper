install_data(
  meson.project_name() + '.desktop',
  install_dir: join_paths(get_option('datadir'), 'applications')
)

install_data(
  'ambr.xml',
  install_dir: join_paths(get_option('datadir'), 'mime', 'packages')
)

test (
  'Validate desktop file',
  find_program('desktop-file-validate'),
  args: join_paths(meson.current_build_dir (), meson.project_name() + '.desktop')
)
