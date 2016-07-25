# Sharing code between two Elixir modules

Two approaches, neither of which I particularly like. Mainly showing to attract
comments and improvement suggestions!

Looking at two modules, `IPv4Routes` and `IPv6Routes`. They basically do the
same thing, but for different types of address (I've removed some of the
functions for clarity):

* read a routes file, and extract and store the addresses found in it
* take a list of hosts to route to a specific place, and generate a file with
  commands to add new routes and remove those no longer required

The functions in these modules are part of a pipeline, which also generates
various other files. A `context` map is passed down the pipeline, and any data
required by later stages is added to this map. The calling code looks something
like this:

    %{root: options[:root]}
    |> HostList.parse
    |> IPv4Routes.read_previous
    |> IPv6Routes.read_previous
    |> ... various other steps
    |> IPv4Routes.write_changes
    |> IPv6Routes.write_changes
