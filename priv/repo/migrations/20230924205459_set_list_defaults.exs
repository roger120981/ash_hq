defmodule AshHq.Repo.Migrations.SetListDefaults do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    alter table(:options) do
      modify(:links, :map, default: %{})
    end

    alter table(:functions) do
      modify(:heads_html, {:array, :text}, default: [])
      modify(:heads, {:array, :text}, default: [])
    end

    alter table(:dsls) do
      modify(:imports, {:array, :text}, default: [])
    end
  end

  def down do
    alter table(:dsls) do
      modify(:imports, {:array, :text}, default: nil)
    end

    alter table(:functions) do
      modify(:heads, {:array, :text}, default: nil)
      modify(:heads_html, {:array, :text}, default: nil)
    end

    alter table(:options) do
      modify(:links, :map, default: nil)
    end
  end
end