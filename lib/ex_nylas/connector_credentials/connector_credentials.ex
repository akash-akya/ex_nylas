defmodule ExNylas.ConnectorCredentials do
  @moduledoc """
  Interface for Nylas connector credentials.
  """

  alias ExNylas.API
  alias ExNylas.Connection, as: Conn
  alias ExNylas.ConnectorCredential, as: Cred

  @doc """
  List connector credentials.

  Example
      {:ok, creds} = ExNylas.ConnectorCredentials.list(conn, provider)
  """
  def list(%Conn{} = conn, provider, params \\ []) do
    Req.new(
      url: "#{conn.api_server}/v3/connectors/#{provider}/creds",
      auth: API.auth_bearer(conn),
      headers: API.base_headers(),
      params: params
    )
    |> API.maybe_attach_telemetry(conn)
    |> Req.get(conn.options)
    |> API.handle_response(Cred)
  end

  @doc """
  List connector credentials.

  Example
      creds = ExNylas.ConnectorCredentials.list!(conn, provider)
  """
  def list!(%Conn{} = conn, provider, params \\ []) do
    case list(conn, provider, params) do
      {:ok, res} -> res
      {:error, reason} -> raise ExNylasError, reason
    end
  end

  @doc """
  Create a connector credential.

  Example
      {:ok, cred} = ExNylas.ConnectorCredentials.create(conn, provider, body)
  """
  def create(%Conn{} = conn, provider, body) do
    Req.new(
      url: "#{conn.api_server}/v3/connectors/#{provider}/creds",
      auth: API.auth_bearer(conn),
      headers: API.base_headers(["content-type": "application/json"]),
      json: body
    )
    |> API.maybe_attach_telemetry(conn)
    |> Req.post(conn.options)
    |> API.handle_response(Cred)
  end

  @doc """
  Create a connector credential.

  Example
      cred = ExNylas.ConnectorCredentials.create!(conn, provider, body)
  """
  def create!(%Conn{} = conn, provider, body) do
    case create(conn, provider, body) do
      {:ok, res} -> res
      {:error, reason} -> raise ExNylasError, reason
    end
  end

  @doc """
  Find a connector credential.

  Example
      {:ok, cred} = ExNylas.ConnectorCredentials.find(conn, provider, id)
  """
  def find(%Conn{} = conn, provider, id) do
    Req.new(
      url: "#{conn.api_server}/v3/connectors/#{provider}/creds/#{id}",
      auth: API.auth_bearer(conn),
      headers: API.base_headers()
    )
    |> API.maybe_attach_telemetry(conn)
    |> Req.get(conn.options)
    |> API.handle_response(Cred)
  end

  @doc """
  Find a connector credential.

  Example
      cred = ExNylas.ConnectorCredentials.find(conn, provider, id)
  """
  def find!(%Conn{} = conn, provider, id) do
    case find(conn, provider, id) do
      {:ok, res} -> res
      {:error, reason} -> raise ExNylasError, reason
    end
  end

  @doc """
  Delete a connector credential.

  Example
      {:ok, res} = ExNylas.ConnectorCredentials.delete(conn, provider, id)
  """
  def delete(%Conn{} = conn, provider, id) do
    Req.new(
      url: "#{conn.api_server}/v3/connectors/#{provider}/creds/#{id}",
      auth: API.auth_bearer(conn),
      headers: API.base_headers()
    )
    |> API.maybe_attach_telemetry(conn)
    |> Req.delete(conn.options)
    |> API.handle_response()
  end

  @doc """
  Delete a connector credential.

  Example
      res = ExNylas.ConnectorCredentials.delete!(conn, provider, id)
  """
  def delete!(%Conn{} = conn, provider, id) do
    case delete(conn, provider, id) do
      {:ok, res} -> res
      {:error, reason} -> raise ExNylasError, reason
    end
  end

  @doc """
  Update a connector credential.

  ## Examples

      iex> {:ok, cred} = ExNylas.ConnectorCredentials.update(conn, provider, id, changeset)
  """
  def update(%Conn{} = conn, provider, id, changeset) do
    Req.new(
      url: "#{conn.api_server}/v3/connectors/#{provider}/creds/#{id}",
      auth: API.auth_bearer(conn),
      headers: API.base_headers(["content-type": "application/json"]),
      json: changeset
    )
    |> API.maybe_attach_telemetry(conn)
    |> Req.patch(conn.options)
    |> API.handle_response(Cred)
  end

  @doc """
  Update a connector credential.

  ## Examples

      iex> cred = ExNylas.ConnectorCredentials.update!(conn, provider, id, changeset)
  """
  def update!(%Conn{} = conn, provider, id, changeset) do
    case update(conn, provider, id, changeset) do
      {:ok, res} -> res
      {:error, reason} -> raise ExNylasError, reason
    end
  end
end
