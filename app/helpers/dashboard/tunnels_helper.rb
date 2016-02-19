module Dashboard::TunnelsHelper

  def distr_port_by_entrance_id(id)
    tunnel = Tunnel.where(entrance_id: id).last
    if tunnel.nil?
      '35000'
    else
      tunnel.entrance_port += 1
    end
  end

end
