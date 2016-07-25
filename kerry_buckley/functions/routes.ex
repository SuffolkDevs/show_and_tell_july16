defmodule CFOSS2.Routes do
  def read_previous(context, filename, regex, key_to_set) do
    addresses = context[:root]
    |> CFOSS2.File.read_lines(filename)
    |> Enum.map(fn line -> extract_address line, regex end)
    |> Enum.reject(fn a -> is_nil a end)
    Map.merge context, %{key_to_set => addresses}
  end

  defp extract_address(line, regex) do
    regex
    |> Regex.run(line)
    |> return_address
  end

  defp return_address(nil), do: nil
  defp return_address([_, address]), do: address

  def write_changes(context, previous_addresses_key, matching_host_predicate, format_addition, format_removal, filename) do
    previous_addresses = context[previous_addresses_key]
    addresses = addresses(context, matching_host_predicate)
    additions = Enum.map addresses -- previous_addresses, format_addition
    removals = Enum.map previous_addresses -- addresses, format_removal
    CFOSS2.File.write_lines additions ++ removals, context.root, filename
    context
  end

  defp addresses(context, matching_host_predicate) do
    context[:hosts]
    |> Enum.filter(matching_host_predicate)
    |> Enum.map(fn host -> host.address end)
  end
end
