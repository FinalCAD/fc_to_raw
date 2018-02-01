require 'openssl'

module FcToRaw
  module Processor
    class Base
      include FileModel::Processor::Base

      def process(model:, context: {})
        context = context.merge(options)

        file = write_to_binfile(%W[decrypt_file .fc], decrypt(File.new(model.source_path).read))

        copy(
          file,
          compose_path(model)
        )
      end

      private

      # Returns an Pathname
      def compose_path(model)
        export_path + model.dir_path + Pathname(model.name.to_s + '.pdf')
      end

      def decrypt(contents)
        _process(cipher(:decrypt), contents)
      end

      def _process(cipher, contents)
        cipher.update(contents) + cipher.final
      end

      def cipher(type=:encrypt)
        cipher = OpenSSL::Cipher::AES.new(128, :CBC)
        cipher.public_send(type)
        cipher.key = aes_key
        cipher.iv  = aes_key
        cipher
      end

      def write_to_binfile(tempfile_args, contents)
        file = Tempfile.new(tempfile_args)
        file.binmode
        file.write(contents)
        file.close
        file
      end

      AES_KEY = 'FcDtg023'.encode('utf-16le').freeze
      private_constant :AES_KEY

      def aes_key
        AES_KEY
      end

    end
  end
end
