require 'active_record/connection_adapters/sqlite3_adapter'

module ActiveRecord
  module ConnectionAdapters
    class SQLite3Adapter < (defined?(SQLiteAdapter) ? SQLiteAdapter : AbstractAdapter)
      if ActiveRecord::VERSION::MAJOR >= 5 && ActiveRecord::VERSION::MINOR >= 1
        def type_to_sql_with_enum(type, limit: nil, **args)
          if type.to_s == "enum" || type.to_s == "set"
            type, limit = :string, nil
          end
          type_to_sql_without_enum(type, limit: limit, **args)
        end
      else
        def type_to_sql_with_enum(type, limit=nil, *args)
          if type.to_s == "enum" || type.to_s == "set"
            type, limit = :string, nil
          end
          type_to_sql_without_enum(type, limit, *args)
        end
      end
      alias_method :type_to_sql_without_enum, :type_to_sql
      alias_method :type_to_sql, :type_to_sql_with_enum
    end
  end
end
