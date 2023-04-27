defmodule FzHttpWeb.JSON.DeviceView do
  @moduledoc """
  Handles JSON rendering of Device records.
  """
  use FzHttpWeb, :view

  alias FzHttp.Devices

  def render("index.json", %{devices: devices, defaults: defaults}) do
    %{data: render_many(devices, __MODULE__, "device.json", defaults: defaults)}
  end

  def render("show.json", %{device: device, defaults: defaults}) do
    %{data: render_one(device, __MODULE__, "device.json", defaults: defaults)}
  end

  @keys_to_render ~w[
    id
    rx_bytes
    tx_bytes
    name
    description
    public_key
    preshared_key
    use_default_allowed_ips
    use_default_connected_sites
    use_default_dns
    use_default_endpoint
    use_default_mtu
    use_default_persistent_keepalive
    endpoint
    mtu
    persistent_keepalive
    allowed_ips
    connected_sites
    dns
    remote_ip
    ipv4
    ipv6
    latest_handshake
    updated_at
    inserted_at
    user_id
  ]a
  def render("device.json", %{device: device, defaults: defaults}) do
    Map.merge(
      Map.take(device, @keys_to_render),
      %{
        server_public_key: Application.get_env(:fz_vpn, :wireguard_public_key),
        endpoint: Devices.get_endpoint(device, defaults),
        allowed_ips: Devices.get_allowed_ips(device, defaults),
        connected_sites: Devices.get_connected_sites(device, defaults),
        dns: Devices.get_dns(device, defaults),
        persistent_keepalive: Devices.get_persistent_keepalive(device, defaults),
        mtu: Devices.get_mtu(device, defaults)
      }
    )
  end
end
