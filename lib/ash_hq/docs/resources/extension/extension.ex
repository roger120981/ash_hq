defmodule AshHq.Docs.Extension do
  @moduledoc false

  use Ash.Resource,
    domain: AshHq.Docs,
    data_layer: AshPostgres.DataLayer

  actions do
    default_accept :*
    defaults [:update, :destroy]

    read :read do
      primary? true
      pagination offset?: true, countable: true, default_limit: 25, required?: false
    end

    create :create do
      primary? true

      argument :library_version, :uuid do
        allow_nil? false
      end

      argument :dsls, {:array, :map}
      change manage_relationship(:library_version, type: :append_and_remove)
      change {AshHq.Docs.Changes.AddArgToRelationship, arg: :library_version, rel: :dsls}

      change {AshHq.Docs.Changes.AddArgToRelationship,
              attr: :id, arg: :extension_id, rel: :dsls, generate: &Ash.UUID.generate/0}

      change manage_relationship(:dsls, type: :create)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :module, :string do
      public? true
    end

    timestamps()
  end

  relationships do
    belongs_to :library_version, AshHq.Docs.LibraryVersion do
      public? true
      allow_nil? true
    end

    has_many :dsls, AshHq.Docs.Dsl do
      public? true
    end

    has_many :options, AshHq.Docs.Option do
      public? true
    end
  end

  postgres do
    table "extensions"
    repo AshHq.Repo

    references do
      reference :library_version, on_delete: :delete
    end
  end

  code_interface do
    define :destroy
  end

  resource do
    description "An Ash DSL extension."
  end
end
