defmodule TestWeb.UserLive.Instrucciones.Index do
  alias Test.Instrucciones
  use TestWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket }
  end

end
