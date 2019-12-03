defmodule Instream.Database do
  @moduledoc """
  Defines a database.

  ## Usage

      defmodule MyDatabase do
        use Instream.Database

        database do
          name "my_database"
        end
      end

  ## Metadata

  The metadata of a database (e.g. the name) can
  be retrieved using the `__meta__/1` method.
  """

  alias Instream.Database.Validator

  defmacro __using__(_opts) do
    quote do
      @after_compile unquote(__MODULE__)

      import unquote(__MODULE__), only: [database: 1]
    end
  end

  defmacro __after_compile__(%{module: module}, _bytecode) do
    Validator.proper_database?(module)
  end

  @doc """
  Defines the database.
  """
  defmacro database(do: block) do
    quote do
      @behaviour unquote(__MODULE__)

      @name nil

      try do
        # scoped import
        import unquote(__MODULE__)
        unquote(block)
      after
        :ok
      end

      def __meta__(:name), do: @name
    end
  end

  @doc """
  Provides metadata access for a database.

  ## Available information

  - `:name` - the name of the database
  """
  @callback __meta__(atom) :: any

  @doc """
  Defines the name of the database.
  """
  defmacro name(dbname) do
    quote do
      @name unquote(dbname)
    end
  end
end
