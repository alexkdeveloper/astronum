astronum_sources = [
  'main.vala',
  'window.vala',
  'calculator.vala'
]

astronum_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1')
]

gnome = import('gnome')

astronum_sources += gnome.compile_resources('astronum-resources',
  'astronum.gresource.xml',
  c_name: 'astronum'
)

executable('com.github.alexkdeveloper.astronum', astronum_sources,
  include_directories: config_h_dir, 
vala_args: ['--target-glib=2.50', meson.source_root() + '/src/config.vapi'], 
c_args: ['-include', 'config.h'], dependencies: astronum_deps,
  install: true,
)
