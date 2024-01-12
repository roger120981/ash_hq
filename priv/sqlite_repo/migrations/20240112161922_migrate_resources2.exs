defmodule AshHq.SqliteRepo.Migrations.MigrateResources2 do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_sqlite.generate_migrations`
  """

  use Ecto.Migration

  def up do
    drop_if_exists unique_index(:extensions, [:library_version_id, :name],
                     name: "extensions_unique_name_by_library_version_index"
                   )

    alter table(:extensions) do
      remove :order
      remove :type
      remove :default_for_target
      remove :target
      remove :name
    end

  end

  def down do
    create unique_index(:extensions, [:library_version_id, :name],
             name: "extensions_unique_name_by_library_version_index"
           )

    alter table(:extensions) do
      add :name, :text, null: false
      add :target, :text
      add :default_for_target, :boolean
      add :type, :text, null: false
      add :order, :bigint, null: false
    end
  end
end
