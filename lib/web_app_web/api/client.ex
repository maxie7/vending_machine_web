defmodule WebAppWeb.Api.Client do
  @base_url "http://localhost:4000/api/"
  @headers [{"Content-Type", "application/json"}]

  def create_a_user(body) do
    case HTTPoison.post!(@base_url <> "users/sign_up", Jason.encode!(%{"user" => body}), @headers) do
      %HTTPoison.Response{status_code: 201, body: resp_body} ->
        {:ok, Jason.decode(resp_body)}

      %HTTPoison.Response{status_code: status_code} when status_code > 399 ->
        {:error, "Error from API, status code: #{status_code}"}

      %HTTPoison.Error{reason: reason} ->
        {:error, reason}

      _ ->
        {:error, "Something went wrong"}
    end
  end

  def sign_in(body) do
    case HTTPoison.post!(@base_url <> "users/sign_in", Jason.encode!(body), @headers) do
      %HTTPoison.Response{status_code: 200, body: resp_body, headers: headers} ->
        cookie =
          headers
          |> List.keyfind("set-cookie", 0)
          |> Kernel.elem(1)
          |> String.split(";")
          |> List.first()
        {:ok, [Jason.decode(resp_body), cookie]}

      %HTTPoison.Response{status_code: status_code} when status_code > 399 ->
        {:error, "Error from API, status code: #{status_code}"}

      %HTTPoison.Error{reason: reason} ->
        {:error, reason}

      _ ->
        {:error, "Can't log in, please try again later!"}
    end
  end

  def get_products() do
    case HTTPoison.get!(@base_url <> "products", @headers) do
      %HTTPoison.Response{status_code: 200, body: resp_body} ->
        {:ok, Jason.decode(resp_body)}

      %HTTPoison.Response{status_code: status_code} when status_code > 399 ->
        {:error, "Error from API, status code: #{status_code}"}

      %HTTPoison.Error{reason: reason} ->
        {:error, reason}

      _ ->
        {:error, "Can't retrieve any products, please try again later!"}
    end
  end
end
