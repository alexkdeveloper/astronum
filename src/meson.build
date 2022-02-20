astronum_sources = [
  'main.vala',
  'window.vala',
  'calculator.vala'
]

astronum_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
]

gnome = import('gnome')

astronum_sources += gnome.compile_resources('astronum-resources',
  'astronum.gresource.xml',
  c_name: 'astronum'
)

executable('com.github.alexkdeveloper.astronum', astronum_sources,
  vala_args: '--target-glib=2.50',  dependencies: astronum_deps,
  install: true,
)
