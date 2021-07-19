# frozen_string_literal: true

def load_fixture(folder, file)
  File.read(
    File.join(
      Provet.root,
      'spec',
      'fixtures',
      folder,
      "#{file}.json"
    )
  )
end
