require "net/ping"

module Sorairo::Hub
  module Ping
    def send_icmp_echo_req(host)
      raise ArgumentError, message: "Host must not be empty" if host.nil?
      ping = Net::Ping::ICMP.new(host, timeout: 10)
      puts "#{host}: #{ping.ping? ? "OK" : "FAILED"}"
    end

    module_function :send_icmp_echo_req
  end
end
