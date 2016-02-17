module DashboardHelper
  def valid_tunnel_status(tunnel_id)
    case Tunnel.find(tunnel_id).status
    when 0 then "red"
    when 1 then "green"
    end
  end
end
