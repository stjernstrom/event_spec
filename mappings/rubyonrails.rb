require 'lib/mapping'
require 'active_support/inflector'

mp = Mapping.get_instance

mp.add_mapping(%r%^app/models/(.*)\.rb$%) { |_, m|
  ["spec/models/#{m[1]}_spec.rb"]
}

mp.add_mapping(%r%^(test|spec)/fixtures/(.*).yml$%) { |_, m|
  ["spec/models/#{m[2].singularize}_spec.rb"] + mp.files_matching(%r%^spec\/views\/#{m[2]}/.*_spec\.rb$%)
}

mp.add_mapping(%r%^spec/(models|controllers|views|helpers|lib)/.*rb$%) { |filename, _|
  [ filename ]
}

mp.add_mapping(%r%^app/views/(.*)$%) { |_, m|
  mp.files_matching %r%^spec/views/#{m[1]}_spec.rb$%
}

mp.add_mapping(%r%^app/controllers/(.*)\.rb$%) { |_, m|
  if m[1] == "application"
    mp.files_matching %r%^spec/controllers/.*_spec\.rb$%
  else
    ["spec/controllers/#{m[1]}_spec.rb"]
  end
}

mp.add_mapping(%r%^config/routes\.rb$%) {
  mp.files_matching %r%^spec/(controllers|views|helpers)/.*_spec\.rb$%
}

mp.add_mapping(%r%^lib/(.*)\.rb$%) { |_, m|
  ["spec/lib/#{m[1]}_spec.rb"]
}
