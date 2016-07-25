defmodule CFOSS2.Routes do
  defmacro __using__(_) do
    quote do
      def read_previous(context) do
        addresses = context[:root]
                    |> CFOSS2.File.read_lines("#{@address_type}-out.txt")
                    |> Enum.map(&extract_address/1)
                    |> Enum.reject(fn a -> is_nil a end)
        Map.merge context, %{"previous_#{@address_type}_addresses": addresses}
      end

      def extract_address(line) do
        @route_address_regex
        |> Regex.run(line)
        |> return_address
      end

      defp return_address(nil), do: nil
      defp return_address([_, address]), do: address

      def write_changes(context) do
        previous_addresses = context[:"previous_#{@address_type}_addresses"]
        addresses = filter_addresses(context)
        additions = Enum.map addresses -- previous_addresses, &format_addition/1
        removals = Enum.map previous_addresses -- addresses, &format_removal/1
        CFOSS2.File.write_lines additions ++ removals, context.root, "#{@address_type}-changes-since-last-run.txt"
        context
      end

      def filter_addresses(context) do
        context[:hosts]
        |> Enum.filter(fn host -> apply CFOSS2.Host, :"#{@address_type}?", [host] end)
        |> Enum.map(fn host -> host.address end)
      end
    end
  end
end
