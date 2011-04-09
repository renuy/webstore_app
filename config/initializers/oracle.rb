ENV['TZ'] = 'UTC'

ActiveSupport.on_load(:active_record) do
  ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.class_eval do
    self.emulate_integers_by_column_name = true
    self.string_to_date_format = "%d.%m.%Y"
    self.string_to_time_format = "%d.%m.%Y %H:%M:%S"
    def self.is_integer_column? (name, table_name = nil)
      name =~ /((^|_)id$|_cnt$)/i
    end
  end
end