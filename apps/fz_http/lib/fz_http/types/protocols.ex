defimpl String.Chars, for: Postgrex.INET do
  def to_string(%Postgrex.INET{} = inet), do: FzHttp.Types.INET.to_string(inet)
end

defimpl Phoenix.HTML.Safe, for: Postgrex.INET do
  def to_iodata(%Postgrex.INET{} = inet), do: FzHttp.Types.INET.to_string(inet)
end

defimpl Jason.Encoder, for: Postgrex.INET do
  def encode(%Postgrex.INET{} = struct, opts) do
    Jason.Encode.string("#{struct}", opts)
  end
end

defimpl Jason.Encoder, for: FzHttp.Types.IPPort do
  def encode(%FzHttp.Types.IPPort{} = ip_port, opts) do
    Jason.Encode.string(FzHttp.Types.IPPort.to_string(ip_port), opts)
  end
end

defimpl String.Chars, for: FzHttp.Types.IPPort do
  def to_string(%FzHttp.Types.IPPort{} = ip_port), do: FzHttp.Types.IPPort.to_string(ip_port)
end

defimpl Phoenix.HTML.Safe, for: FzHttp.Types.IPPort do
  def to_iodata(%FzHttp.Types.IPPort{} = ip_port), do: FzHttp.Types.IPPort.to_string(ip_port)
end
