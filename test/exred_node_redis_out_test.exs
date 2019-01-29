defmodule Exred.Node.RedisOutTest do
  use ExUnit.Case
  doctest Exred.Node.RedisOut

  use Exred.NodeTest, module: Exred.Node.RedisOut

  setup_all do
    start_node(Exred.Node.RedisDaemon)
    start_node()
  end

  test "SET hello", context do
    Exred.Node.RedisOut.add_out_node(context.pid, self)
    msg = %{payload: ["hello", "world"]}
    send(context.pid, msg)

    assert_receive %{payload: "OK"}
  end
end
