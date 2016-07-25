defmodule CFOSS2.IPv6Routes do
  alias CFOSS2.Host
  alias CFOSS2.Routes

  def read_previous(context) do
    Routes.read_previous context, "ipv6-out.txt", ~r|^ip route (\S*)/128.*$|, :previous_ipv6_addresses
  end

  def write_changes(context) do
    Routes.write_changes(context, :previous_ipv6_addresses, &Host.ipv6?/1,
     &format_addition/1, &format_removal/1, "ipv6-changes-since-last-run.txt")
  end

  def format_addition(address) do
    "ip route #{address}/128 Null0 5"
  end

  def format_removal(address) do
    "no ip route #{address}/128 Null0 5"
  end
end
