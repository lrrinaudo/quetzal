migration 1, :make_desc_text do
  up do
    modify_table :resumen do
      change_column :descripcion, 'text'
    end
  end
end
