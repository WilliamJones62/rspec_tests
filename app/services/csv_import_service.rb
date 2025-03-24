class CsvImportService
  def import_monster(data, csv_data)
    column_names = data[0]

    csv_data.each do |row|
        inserted_data = {
            column_names[0] => row[0],
            column_names[1] => row[1],
            column_names[2] => row[2],
            column_names[3] => row[3],
            column_names[4] => row[4],
            column_names[5] => row[5]
        }
    
        Monster.create!(inserted_data)
    end
  end
end