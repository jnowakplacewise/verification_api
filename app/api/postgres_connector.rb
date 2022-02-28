require 'sequel'

module API
    class PostgresDB
        def self.connect()
            db = Sequel.connect(
                :adapter => 'postgres',
                :user => 'root',
                :password => 'password',
                :host => '0.0.0.0',
                :port => '5433',
                :database => 'verifications')
            db
        end
    end

    class DBHandler
        def initialize(table)
            @table = table
            @database = API::PostgresDB.connect()
        end

        def insert_card(hash_query)
            begin
                @database[@table].insert(hash_query)
            rescue Sequel::UniqueConstraintViolation
                @database[@table].where(card_code: hash_query[:card_code])
            end
        end

        def get_all()
            result = @database[@table].select()
            result = result.map {|row| row}
        end
    end
end 
