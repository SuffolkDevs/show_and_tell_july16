defmodule CFOSS2.IPv6Routes do
  @address_type "ipv6"
  @route_address_regex ~r|^ip route (\S*)/128.*$|
  use CFOSS2.Routes

  def format_addition(address) do
    "ip route #{address}/128 Null0 5"
  end

  def format_removal(address) do
    "no ip route #{address}/128 Null0 5"
  end
end
