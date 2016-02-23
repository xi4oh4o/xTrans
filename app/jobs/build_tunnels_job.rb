class BuildTunnelsJob < ActiveJob::Base
  queue_as :default

  def perform(args)
    @entrance = Entrance.find(args[:entrance_id])
    build_dnat(@entrance.ip,
               @entrance.port,
               args[:entrance_port],
               args[:target_address],
               args[:destination_port])
  end

  private
    def build_dnat(server_ip,
                   server_port,
                   dport,
                   to_ip,
                   to_ip_port)

      require 'sshkit'
      include SSHKit::DSL
      begin
        on "root@#{server_ip}:#{server_port}" do |host|
          execute ("iptables -t nat -A PREROUTING -p tcp -i eth0 \
--dport #{dport} -j DNAT --to #{to_ip}:#{to_ip_port}")
          execute "iptables -t nat -A POSTROUTING -d #{to_ip} -j MASQUERADE"
        end
        tunnel = Tunnel.find_by(
                                entrance_port:    dport,
                                target_address:   to_ip,
                                destination_port: to_ip_port)
        tunnel.update(status: 1)
      rescue
        logger.fatal "Fail with #{server_ip}:#{server_port} and dport:#{dport}"
      end
    end
end
