# Copyright 2019 Grabtaxi Holdings PTE LTE (GRAB), All rights reserved.
# Use of this source code is governed by an MIT-style license that can be found in the LICENSE file

require 'fileutils'

module Pod
  class Command
    class BinaryCache < Command
      include Command::ProjectDirectory

      self.summary = "Pod Binary Cache commands"

      self.description = <<-DESC
        Fetch/Prebuild pod frameworks
      DESC

      def self.options
        [
          ['--cmd', 'Commands to fetch, prebuild pod frameworks']
        ].concat(super)
      end

      def initialize(argv)
        @podspec_name = argv.shift_argument
        @cmd = argv.option('cmd', nil)
        puts "BinaryCache run: #{@cmd}"
        super
      end

      def run
        config_file_path = "#{config.installation_root}/PodBinaryCacheConfig.json"
        if not File.exists?(config_file_path)
          raise "#{config_file_path} not exist"
        end
        system "python3 #{__dir__}/PythonScripts/prebuild_lib_cli.py --cmd=#{@cmd} --config_path=#{config_file_path}"
      end
    end
  end
end
