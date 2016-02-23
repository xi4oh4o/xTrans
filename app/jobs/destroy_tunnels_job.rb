class DestroyTunnelsJob < ActiveJob::Base
  queue_as :default

  def perform(args)
    @tunnel = Tunnel.find(args)
    @entrance = Entrance.find(@tunnel.entrance_id)
    destroy_dnat(@entrance.ip,
                 @entrance.port,
                 @tunnel.entrance_port,
                 @tunnel.target_address,
                 @tunnel.destination_port
                )
  end

  private
    def destroy_dnat(server_ip,
                     server_port,
                     dport,
                     to_ip,
                     to_ip_port)

      require 'sshkit'
      require 'sshkit/dsl'
      begin
        on "root@#{server_ip}:#{server_port}" do |host|
          execute ("iptables -t nat -D PREROUTING -p tcp -i eth0 \
--dport #{dport} -j DNAT --to #{to_ip}:#{to_ip_port}")
          execute "iptables -t nat -D POSTROUTING -d #{to_ip} -j MASQUERADE"
        end
      rescue
        logger.fatal "Fail with #{server_ip}:#{server_port} and dport:#{dport}"
      end
    end
end
