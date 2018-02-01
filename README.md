# FcToRaw

[![Maintainability](https://api.codeclimate.com/v1/badges/b555e20a16d6c8776959/maintainability)](https://codeclimate.com/github/FinalCAD/fc_to_raw/maintainability)

[![Dependency Status](https://gemnasium.com/FinalCAD/fc_to_raw.svg)](https://gemnasium.com/FinalCAD/fc_to_raw)

[![Build Status](https://travis-ci.org/FinalCAD/fc_to_raw.svg?branch=master)](https://travis-ci.org/FinalCAD/fc_to_raw) (Travis CI)

[![Coverage Status](https://coveralls.io/repos/FinalCAD/fc_to_raw/badge.svg?branch=master&service=github)](https://coveralls.io/github/FinalCAD/fc_to_raw?branch=master)

[![Inline docs](http://inch-ci.org/github/FinalCAD/fc_to_raw.svg?branch=master)](http://inch-ci.org/github/FinalCAD/fc_to_raw)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/fc_to_raw`. To experiment with that code, run `bin/console` for an interactive prompt.

A processor based on https://github.com/FinalCAD/file_model `FileModel::Processor::Base`

The goal is to decrypt files.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fc_to_raw'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fc_to_raw

## Usage

You need to add `file_model` gem https://rubygems.org/gems/file_model

```
require 'file_model'
```

Define your model based on `FileModel::Model::File` to override behavior

```
class DecryptPdf
  include FileModel::Model::File

  def skip?
    extension.to_s != '.fc'
  end
end
```

Use the `FileModel::Import::Dir` of `file_model`

```
source_path = '../file_model/spec/fixtures/archive/input'
import = FileModel::Import::Dir.new(source_path: source_path, model: DecryptPdf)
```

Create the directory where you want your PDF files (Could be the same as input if you want to work in the same directory)

```
export_path = "tmp/#{Time.now.to_s(:number)}"
FileUtils.mkdir_p(export_path)
```

get an instance of the processor

```
processor = FcToRaw::Processor::Base.new({ export_path: Pathname(export_path) })
```

process your files

```
options = {}
import.each(options) do |model|
  processor.process(model: model, context: options)
  puts("File: #{model.source_path} Successfully treated")
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fc_to_raw. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FcToRaw project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/fc_to_raw/blob/master/CODE_OF_CONDUCT.md).
