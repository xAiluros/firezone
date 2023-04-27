defmodule FzHttp.Repo.Migrations.DevicesAddDefaultConnectedSitesColumn do
  use Ecto.Migration

  def change do
    alter table(:configurations) do
      add(:default_client_connected_sites, {:array, :inet}, default: [])
    end
  end
end
