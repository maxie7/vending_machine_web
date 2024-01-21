defmodule WebAppWeb.FormData do
  alias Ecto.Changeset

  @types %{username: :string, password: :string, role: :string}

  def validate(params) do
    {%{}, @types}
    |> Changeset.cast(params, Map.keys(@types))
    |> Changeset.validate_required([:username, :password])
    |> Changeset.validate_length(:password, min: 4, max: 20)
    |> Map.put(:action, :validate)
  end

end
