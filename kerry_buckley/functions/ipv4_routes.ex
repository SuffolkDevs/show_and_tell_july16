defmodule CFOSS2.IPv4Routes do
  alias CFOSS2.Host
  alias CFOSS2.Routes

  def read_previous(context) do
    Routes.read_previous context, "ipv4-out.txt", ~r|^ip route (\S*).*$|, :previous_ipv4_addresses
  end

  def write_changes(context) do
    Routes.write_changes(context, :previous_ipv4_addresses, &Host.ipv4?/1,
     &format_addition/1, &format_removal/1, "ipv4-changes-since-last-run.txt")
  end

  def format_addition(address) do
    "ip route #{address} 255.255.255.255 Null0 5"
  end

  def format_removal(address) do
    "no ip route #{address} 255.255.255.255 Null0 5"
  end
end
