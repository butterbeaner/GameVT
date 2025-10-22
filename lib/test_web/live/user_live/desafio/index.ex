defmodule TestWeb.UserLive.Desafio.Index do
  alias Test.Novalores
  alias Test.Valores
  alias Test.Desafios
  use TestWeb, :live_view

  def mount(_params, _session, socket) do
    IO.inspect(socket)
    {:ok,
    socket
      |> push_event( "check_local_storage", %{})
      |> assign( :task, %{desafio: "", valores: [],novalores: []})
  }
  end




  def handle_event("no_desafio_in_local_storage", _params, socket) do
    valores = Valores.random_valor()
    novalores = Novalores.random_novalor()
    task = %{
      desafio: Desafios.random_desafio(),
      valores: valores,
      novalores: novalores
    }

    {:noreply,
      socket
        |> assign(:task, %{
          desafio: task.desafio,
          valores: task.valores,
          novalores: task.novalores
        })
        |> push_event("save_to_local_storage", task)
    }
  end

  def handle_event("desafio_from_local_storage", %{"desafio" => desafio, "valores" => valores, "novalores" => novalores}, socket) do

    {:noreply, assign(socket, :task, %{desafio: desafio, valores: valores, novalores: novalores})}
  end



end
