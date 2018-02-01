RSpec.describe FcToRaw::Processor::Base do
  let(:model) do
    Class.new do
      include FileModel::Model::File

      def skip?
        extension.to_s != '.fc'
      end
    end
  end

  let(:export_path)         { Dir.mktmpdir }
  let(:options)             {{ export_path: Pathname(export_path) }}
  let(:decrypted_file_path) { 'spec/fixtures/file.fc' }

  subject { described_class.new(options) }

  before { FileUtils.mkdir_p(export_path) }

  it 'should decrypt the fc file to a PDF file' do
    expect {
      subject.process(model: model.new(decrypted_file_path))
    }.to change {
      File.exists?(export_path + '/' + 'spec/fixtures/file.pdf')
    }.to(true)
  end

  after { FileUtils.remove_entry(export_path) }
end
