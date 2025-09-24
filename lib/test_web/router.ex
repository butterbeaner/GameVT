defmodule TestWeb.Router do
  use TestWeb, :router

  import TestWeb.UserAuth

  pipeline :users do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TestWeb.Layouts, :user}
    plug :protect_from_forgery
  end




  scope "/", TestWeb do
    pipe_through [:users]
    get "/", PageController, :home
    live "/instrucciones", UserLive.Instrucciones.Index
    live "/desafio", UserLive.Desafio.Index

  end
end
