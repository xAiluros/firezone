defmodule FzHttp.Repo.Migrations.DevicesAddUseDefaultConnectedSitesColumn do
  use Ecto.Migration

  def change do
    alter table(:devices) do
      add(:use_default_connected_sites, :boolean, default: true, null: false)
    end
  end
end
