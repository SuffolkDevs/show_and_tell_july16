defmodule CFOSS2.IPv6Routes do
  alias CFOSS2.Host

  def read_previous(context) do
    addresses = context[:root]
    |> CFOSS2.File.read_lines("ipv6-out.txt")
    |> Enum.map(&extract_address/1)
    |> Enum.reject(fn a -> is_nil a end)
    Map.merge context, %{previous_ipv6_addresses: addresses}
  end

  def extract_address(line) do
    ~r|^ip route (\S*)/128.*$|
    |> Regex.run(line)
    |> return_address
  end

  defp return_address(nil), do: nil
  defp return_address([_, address]), do: address

  def ipv6_addresses(context) do
    context[:hosts]
    |> Enum.filter(&Host.ipv6?/1)
    |> Enum.map(fn host -> host.address end)
  end

  def write_changes(context) do
    previous_addresses = context[:previous_ipv6_addresses]
    addresses = ipv6_addresses(context)
    additions = Enum.map addresses -- previous_addresses, &format_addition/1
    removals = Enum.map previous_addresses -- addresses, &format_removal/1
    CFOSS2.File.write_lines additions ++ removals, context.root, "ipv6-changes-since-last-run.txt"
    context
  end

  def format_addition(address) do
    "ip route #{address}/128 Null0 5"
  end

  def format_removal(address) do
    "no ip route #{address}/128 Null0 5"
  end
end
