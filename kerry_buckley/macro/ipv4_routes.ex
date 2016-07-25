defmodule CFOSS2.IPv4Routes do
  @address_type "ipv4"
  @route_address_regex ~r/^ip route (\S*).*$/
  use CFOSS2.Routes

  def format_addition(address) do
    "ip route #{address} 255.255.255.255 Null0 5"
  end

  def format_removal(address) do
    "no ip route #{address} 255.255.255.255 Null0 5"
  end
end
