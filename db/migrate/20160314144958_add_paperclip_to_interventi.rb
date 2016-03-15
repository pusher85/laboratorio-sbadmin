class AddPaperclipToInterventi < ActiveRecord::Migration
  def change
  	add_attachment :interventis, :rapportino
  end
end
