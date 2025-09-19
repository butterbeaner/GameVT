defmodule TestWeb.InstruccionLiveTest do
  use TestWeb.ConnCase

  import Phoenix.LiveViewTest
  import Test.InstruccionesFixtures

  @create_attrs %{instruccion: "some instruccion"}
  @update_attrs %{instruccion: "some updated instruccion"}
  @invalid_attrs %{instruccion: nil}

  setup :register_and_log_in_user

  defp create_instruccion(%{scope: scope}) do
    instruccion = instruccion_fixture(scope)

    %{instruccion: instruccion}
  end

  describe "Index" do
    setup [:create_instruccion]

    test "lists all instrucciones", %{conn: conn, instruccion: instruccion} do
      {:ok, _index_live, html} = live(conn, ~p"/instrucciones")

      assert html =~ "Listing Instrucciones"
      assert html =~ instruccion.instruccion
    end

    test "saves new instruccion", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/instrucciones")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Instruccion")
               |> render_click()
               |> follow_redirect(conn, ~p"/instrucciones/new")

      assert render(form_live) =~ "New Instruccion"

      assert form_live
             |> form("#instruccion-form", instruccion: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#instruccion-form", instruccion: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/instrucciones")

      html = render(index_live)
      assert html =~ "Instruccion created successfully"
      assert html =~ "some instruccion"
    end

    test "updates instruccion in listing", %{conn: conn, instruccion: instruccion} do
      {:ok, index_live, _html} = live(conn, ~p"/instrucciones")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#instrucciones-#{instruccion.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/instrucciones/#{instruccion}/edit")

      assert render(form_live) =~ "Edit Instruccion"

      assert form_live
             |> form("#instruccion-form", instruccion: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#instruccion-form", instruccion: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/instrucciones")

      html = render(index_live)
      assert html =~ "Instruccion updated successfully"
      assert html =~ "some updated instruccion"
    end

    test "deletes instruccion in listing", %{conn: conn, instruccion: instruccion} do
      {:ok, index_live, _html} = live(conn, ~p"/instrucciones")

      assert index_live |> element("#instrucciones-#{instruccion.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#instrucciones-#{instruccion.id}")
    end
  end

  describe "Show" do
    setup [:create_instruccion]

    test "displays instruccion", %{conn: conn, instruccion: instruccion} do
      {:ok, _show_live, html} = live(conn, ~p"/instrucciones/#{instruccion}")

      assert html =~ "Show Instruccion"
      assert html =~ instruccion.instruccion
    end

    test "updates instruccion and returns to show", %{conn: conn, instruccion: instruccion} do
      {:ok, show_live, _html} = live(conn, ~p"/instrucciones/#{instruccion}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/instrucciones/#{instruccion}/edit?return_to=show")

      assert render(form_live) =~ "Edit Instruccion"

      assert form_live
             |> form("#instruccion-form", instruccion: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#instruccion-form", instruccion: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/instrucciones/#{instruccion}")

      html = render(show_live)
      assert html =~ "Instruccion updated successfully"
      assert html =~ "some updated instruccion"
    end
  end
end
