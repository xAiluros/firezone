defmodule FzHttp.Repo.Migrations.DevicesAddConnectedSitesColumn do
  use Ecto.Migration

  def change do
    alter table(:devices) do
      add(:connected_sites, {:array, :inet}, default: [])
    end
  end
end
