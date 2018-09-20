require "sorairo/hub/ping"
require "hashie"
require "thor"

module Sorairo::Hub
  class CLI < Thor
    
    desc "ping", "get ping"
    method_option :file, type: :string, default: "none"
    def ping
      file = options.file
      raise ArgumentError, "file option is required" if file == "none"

      hosts = Hashie::Mash.load(file).hosts

      threads = hosts.map do |host|
        Thread.new(host) do |host|
          Ping.send_icmp_echo_req(host)
        end
      end

      threads.each(&:join)
    end 
  end
end