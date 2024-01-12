defmodule AshHq.SqliteRepo.Migrations.RemoveExtensionFields do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_sqlite.generate_migrations`
  """

  use Ecto.Migration

  def up do
    alter table(:extensions) do
      remove :doc
      remove :sanitized_name
    end

  end

  def down do
    alter table(:extensions) do
      add :sanitized_name, :text, null: false
      add :doc, :text, null: false
    end
  end
end
